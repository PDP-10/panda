/* <SYS/IPCF.H> - TOPS-20 IPCF package
**	This doesn't really belong here.  Eventually it should be
**	moved out or replaced with a more Un*x-like facility.  --KLH
*/

#include <jsys.h>

typedef _KCCtype_char6		char6;
typedef _KCCtype_char7		char7;
typedef int			PID;

#ifndef TRUE
#define TRUE			1
#define FALSE			0
#endif

#define IP_INFO			0	/* PID of <SYSTEM>INFO */
#define IP_MAX_PID_NAME		20	/* seem reasonable to you? */

typedef struct {
    int function;			/* function code */
    PID copy;				/* PID which gets copy of response */
    union {
	PID pid;			/* can be either PID of */
	char7 name[IP_MAX_PID_NAME];	/* PID name */
    } arg;
} ip_irp;				/* INFO Request Packet */

#define IP_IRP_LEN	(sizeof(ip_irp) / sizeof(int))

typedef struct {
    int flags;				/* flag word */
    PID sender;				/* PID of sender */
    PID receiver;			/* PID of receiver */
    unsigned msg_len:18, msg_adr:18;	/* length,,addr of message */
    int user;				/* user# of sender (RET) */
    int capabilities;			/* enabled caps of sender (RET) */
    int connected;			/* sender's connected dir# (RET) */
    char *account;			/* account string of sender (RET) */
    char *node;				/* destination of sender's node */
} ip_pdb;				/* Packet Descriptor Block */

#define IP_PDB_LEN	(sizeof(ip_pdb) / sizeof(int))

PID ip_ask_INFO();			/* ask something of <SYSTEM>INFO */
PID ip_make_PID();			/* make us a PID */
int ip_receive();			/* receive a message */
int ip_send();				/* send a message */
