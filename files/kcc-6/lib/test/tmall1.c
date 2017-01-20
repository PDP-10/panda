#include <stdio.h>
#include <c-env.h>

#ifndef DBG
#define DBG	0
#endif

#if SYS_T20
#define extern
#define add_to_events addvnt
#define cause_core_dump cordmp
#define do_stats dostat
#define dump_events dmpvnt
#define free_event frevnt
#define init_events inivnt
#define random_range ranrng
#define realloc_event reavnt
#define realloc_probability reaprb
#define run_test runtst
#endif

extern int      atoi ();
extern long     random ();
extern char    *sbrk ();

extern char    *malloc ();
extern char    *realloc ();
extern int      free ();

struct memevent {
        int                     m_time;         /* time to go */
        char                   *m_memory;       /* malloc'ed mem */
        unsigned                m_size;         /* size of mem */
        int                     m_id;           /* id, for trace/debug */
        int                     m_realloc;      /* counter, for debugging */
        char                    m_pattern;      /* pattern in memory */
        struct memevent        *m_next;         /* linked list pointer */
};

#ifndef MAX_EVENTS
#define MAX_EVENTS      10000
#endif

struct memevent eventpool[ MAX_EVENTS ];

struct memevent *events;
struct memevent *free_events;

char stdout_buf[ BUFSIZ ];
char stderr_buf[ BUFSIZ ];

int time_to_go;
int new_probability;
int realloc_probability = 25;           /* XXX: should set from argv */
int stat_frequency;

main (argc, argv)
int argc;
char *argv[];
{
        init (argc, argv);
        run_test ();
}

/*
 * run_test ()
 *
 * Run the actual memory test.
 */

run_test ()
{
        while (time_to_go > 0) {
                arrival ();
                service ();
                -- time_to_go;
                if ((time_to_go % stat_frequency) == 0)
                        do_stats ();
        }
}

/*
 * arrival ()
 *
 * With probability new_probability/100, allocate a new piece
 * of memory with some randomly determined size and lifetime,
 * and add it to the memory event list.
 */

arrival ()
{
        if (free_events && odds (new_probability, 100)) {
                register struct memevent *m;
                register char *p;

                m = free_events;
                free_events = m->m_next;
                m->m_next = NULL;

                                        /* XXX: let these be set from argv */
                m->m_size = (unsigned) random_range (1, 100);
                if (time_to_go < 100)
                        m->m_time = random_range (1, time_to_go);
                else
                        m->m_time = random_range (1, 100);

                m->m_pattern = (char) random_range (0, 127);
                m->m_realloc = 0;
                m->m_memory = malloc (m->m_size);
                if (! m->m_memory)
                        out_of_memory ();


                for (p = m->m_memory; p < & m->m_memory[ m->m_size ]; p++)
                        *p = m->m_pattern;

                add_to_events (m);
        }
} /* arrival */

/*
 * do_stats ()
 */

do_stats ()
{
        register struct memevent *m;
        int i;
        long total;

        printf ("---------------------\nTIME Remaining: %d\n", time_to_go);

        /* print other interesting but implementation-dependent stuff here
           (like count of blocks in heap, size of heap, etc) */

        total = 0;
        for (i = 1, m = events; m != NULL; m = m->m_next, i++) {
                printf ("EVENT %5d (id %5d): ", i, m->m_id);
                printf ("SIZE %4d, ", m->m_size);
                printf ("PATTERN 0x%02x, ", m->m_pattern & 0xFF);
                printf ("TIME %4d ", m->m_time);
                if (m->m_realloc > 0)
                        printf ("REALLOC %d", m->m_realloc);
                printf ("\n");
                total += m->m_size;
        }
        printf ("TOTAL events %d, allocated memory %d\n", i-1, total);
        (void) fflush (stdout);
} /* do_stats */

/*
 * service ()
 *
 * Decrement the time remaining on the head event.  If
 * it's time is up (zero), service it.
 *
 * Servicing an event generally means free'ing it (after checking
 * for corruption).  It is also possible (realloc_probability) to
 * realloc the event instead.
 */

service ()
{
        register struct memevent *m;

        if ((m = events) != NULL)
                -- m->m_time;

        while (m != NULL && m->m_time == 0) {
                register char *p;

                for (p = m->m_memory; p < & m->m_memory[ m->m_size ]; p++) {
                        if (*p != m->m_pattern)
                                corrupted ();
                }

                events = m->m_next;     /* delete this event */

                if (time_to_go > 1 && odds (realloc_probability, 100))
                        realloc_event (m);
                else
                        free_event (m);

                m = events;

        }
} /* service */

/*
 * free_event (m)
 *
 * Called to free up the given event, including its memory.
 */

free_event (m)
register struct memevent *m;
{
        free ((char*)m->m_memory);
        m->m_next = free_events;
        free_events = m;
}

/*
 * realloc_event (m)
 *
 * Called from service(), to reallocate an event's memory,
 * rather than freeing it.
 */

realloc_event (m)
register struct memevent *m;
{
        register char *p;
        unsigned new_size;
        unsigned min_size;

                                        /* XXX: let these be set from argv */
        new_size = (unsigned) random_range (1, 100);

        ++ m->m_realloc;                /* for stats */
        m->m_memory = realloc (m->m_memory, new_size);
        if (! m->m_memory)
                out_of_memory ();

        m->m_next = NULL;

        if (time_to_go < 100)
                m->m_time = random_range (1, time_to_go - 1);
        else
                m->m_time = random_range (1, 100);   /* XXX: should set from argv */

        min_size = new_size > m->m_size ? m->m_size : new_size;

        for (p = m->m_memory; p < & m->m_memory[ min_size ]; p++) {
                if (*p != m->m_pattern)
                        corrupted ();
        }

        m->m_size = new_size;
        for (p = m->m_memory; p < & m->m_memory[ m->m_size ]; p++)
                *p = m->m_pattern;


        add_to_events (m);
} /* realloc_event */

/*
 * add_to_events (m)
 *
 * Add the given event structure onto the time-ordered event list.
 */

add_to_events (m)
register struct memevent *m;
{
        register struct memevent *l;
        register struct memevent *ol;

        for (ol = NULL, l = events; l != NULL; ol = l, l = l->m_next) {
                if (l->m_time > m->m_time) {
                        if (ol == NULL) {
                                m->m_next = events;
                                events = m;
                        }
                        else {
                                m->m_next = l;
                                ol->m_next = m;
                        }

                        l->m_time -= m->m_time;
                        return;
                }

                m->m_time -= l->m_time;
        }

        if (events == NULL)
                events = m;
        else
                ol->m_next = m;
} /* add_to_events */

/*
 * init_events ()
 *
 * Set up the memevent pools.
 */

init_events ()
{
        register struct memevent *m;
        int i;

        for (i = 0, m = eventpool; m < & eventpool[ MAX_EVENTS ]; m++, i++) {
                m->m_id = i;
                m->m_next = m + 1;
        }

        eventpool[ MAX_EVENTS-1 ].m_next = NULL;

        free_events = eventpool;
}

/*
 * init (argc, argv)
 *
 * Initialize the memory tests.
 */

init (argc, argv)
int argc;
char *argv[];
{
	if (argc != 4) {
		fprintf (stderr, "usage: %s new_prob time_to_go stat_freq\n", argv[ 0 ]);
		exit (1);
	}
        new_probability = atoi (argv[ 1 ]);
        time_to_go = atoi (argv[ 2 ]);
        stat_frequency = atoi (argv[ 3 ]);

        srand (1);

        init_events ();

        /*
         * Use statically allocated buffers, otherwise
         * stdio() will call malloc to allocate buffers, and
         * this gets confusing when debugging stuff.
         */

        setbuf (stdout, stdout_buf);
        setbuf (stderr, stderr_buf);
}

/*
 * XXX: Should really send SIGQUIT ...
 */

cause_core_dump ()
{
        * (long *) 1 = 5;
}

corrupted ()
{
        printf ("Corrupted\n");
        cause_core_dump ();
}

out_of_memory ()
{
        printf ("Out of memory!\n");
        cause_core_dump ();
}

/*
 * odds (m, n)
 *
 * Return TRUE (non-zero) with probability m out of n.
 */

odds (m, n)
int m;
int n;
{
        return ((rand () % n) < m);
}

/*
 * random_range (lo, hi)
 *
 * Pick a random integer from lo to hi (inclusive).
 */

random_range (lo, hi)
int lo;
int hi;
{
        return ((rand () % (hi - lo + 1)) + lo);
}

#if DBG
/*
 * de_cmpf (m1,m2)
 *
 * compare function for qsort() in dump_events.
 * Sort by memory address of the memory allocated to
 * the event.
 */

int
de_cmpf (m1, m2)
struct memevent **m1;
struct memevent **m2;
{
        unsigned long maddr1 = (unsigned long) (*m1)->m_memory;
        unsigned long maddr2 = (unsigned long) (*m2)->m_memory;

                                        /* sloppy */
        return (maddr1 - maddr2);
}
#endif DBG

/*
 * dump_events ()
 *
 * Useful for debugging.
 */

#if DBG
dump_events ()
{
        static struct memevent *sorted[ MAX_EVENTS ];
        register struct memevent *m;
        register int i;

        fprintf (stderr, "DUMP EVENTS (time remaining = %d)\n", time_to_go);

        for (m = events, i = 0; m != NULL; m = m->m_next, i++)
                sorted[ i ] = m;

        if (i == 0) {
                fprintf (stderr, "No events.\n");
                return;
        }

        qsort ((char *) sorted, i, sizeof (struct memevent *), de_cmpf);

        sorted[ i ] = 0;
        for (i = 0, m = sorted[ 0 ]; m != NULL; m = sorted[ ++i ]) {
                fprintf (stderr, "E# %3d: ", m->m_id);
                fprintf (stderr, "SIZ%4d, ", m->m_size);
                fprintf (stderr, "RANGE: 0x%08x -- 0x%08x ",
                                m->m_memory, m->m_memory + m->m_size - 1);
                (void) fflush (stderr);

                                        /* Peek at the surrounding longs,
                                           for debugging a particular malloc
                                           implementation.  Your choices may
                                           vary. */

                fprintf (stderr, "BOUNDARY TAGS: %4d ", * (long *) (m->m_memory - 4));
                (void) fflush (stderr);
                fprintf (stderr, "%4d\n", * (long *) ((m->m_memory - 8) - (* (long *) (m->m_memory - 4))));
                (void) fflush (stderr);
        }
        fprintf (stderr, "END DUMP_EVENTS\n");
        (void) fflush (stderr);
} /* dump_events */
#endif DBG
