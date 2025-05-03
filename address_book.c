/*
 * This code does not implement free because it is intended to be translated into MIPS.
 */
#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <malloc.h>
#include <stdlib.h>

/*
	mips: 16bytes
*/
typedef struct node{
	int id;
	char* name;
	char* phone;	
	struct node* next; //8bytes, mips => 4bytes
}Node;

Node* head = NULL;
Node* temp = NULL;
int num = 0;


int getInteger()
{
	int t;
	scanf("%d", &t);
	return t;
}

Node* makeNode()
{
	Node* node = (Node*)malloc(sizeof(Node));

	char* name = (char*)malloc(20);
	printf("NAME: ");
	scanf("%19s", name);

	char* phone = (char*)malloc(20);
	printf("PHONE: ");
	scanf("%19s", phone);

	node->id = num;
	num += 1;

	node->name = name;
	node->phone = phone;
	node->next = NULL;
	return node;
}

void append(Node* newNode)
{
	if (head == NULL)
	{
		head = newNode;
		return;
	}
	temp = head;
	while (1)
	{
		if (temp->next == NULL) break;
		temp = temp->next;
	}
	temp->next = newNode;
	return;
}

void showAll()
{
	if (head == NULL)
	{
		printf("Address Book is Empty!\n");
		return;
	}
	temp = head;
	while (1)
	{
		if (temp == NULL) break;
		printf("ID: %d", temp->id);
		printf("NAME: %s     ", temp->name);
		printf("PHONE: %s\n", temp->phone);
		temp = temp->next;
	}
	return;
}

/*
	MenuScreen
*/
void drawScreen0()
{
	printf("\n\n\n\n\n\n\n\n===================\n");
	printf("    WELCOME\n");
	printf("1. ADD\n");
	printf("2. SHOW\n");
	printf("3. SEARCH\n");
	printf("4. DELETE\n");
	printf("===================\n");
	printf("CHOOSE MENU NUM: ");
}

/*
	AddScreen
*/
void drawScreen1()
{
	printf("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n===================\n");
	printf("    ADD\n");
	
	printf("===================\n");
}

int stringCompare(char* a, char* b)
{
	int index = 0;

	while (1)
	{
		char ca = a[index];
		char cb = b[index];

		if (ca != cb) return 0;
		
		if (ca == '\0') return 1;

		index++;
	}
}

int find(char* target_name)
{
	Node* temp = head;
	char* name;
	int cnt = 0;
	while (1)
	{
		if (temp == NULL) break;
		name = temp->name;
		int r = stringCompare(target_name, name);
		if (r)
		{
			cnt++;
			printf("ID: %d\n", temp->id);
			printf("NAME: %s\n", temp->name);
			printf("PHONE: %s\n", temp->phone);
		}
		temp = temp->next;
	}
	return cnt;
}

void search()
{
	printf("\n\n\n\n\n");
	printf("=================\n");
	printf("    SEARCH\n");
	printf("=================\n");

	char* name = malloc(20);
	printf("NAME: ");
	scanf("%s", name);
	printf("-------------\n");
	int r = find(name);
	if (r == 0) printf("Not Found\n");
	return;
}

void deletee()
{
	printf("\n\n\n\n\n");
	printf("=================\n");
	printf("    DELETE\n");
	printf("=================\n");

	if (head == NULL)
	{
		printf("Address Book is Empty!\n");
		return;
	}
	printf("Enter the ID to delete: ");

	int del_id;
	scanf("%d", &del_id);

	if (del_id >= num)
	{
		printf("Target ID doesn't exist.\n");
		return;
	}
	Node* cur = head;
	Node* prev = NULL;
	Node* next = NULL;
	while (1)
	{
		if (cur == NULL) break;

		next = cur->next;

		int t_id = cur->id;
		if (t_id == del_id)
		{
			//head인 경우
			if (cur == head)
			{
				head = next;
				printf("Deleted.\n");
				return;
			}
			else
			{
				prev->next = next;
				printf("Deleted.\n");
				return;
			}
		}

		prev = cur;
		cur = next;
	}

	printf("Target ID doesn't exist.\n");
	return;
}


int main()
{
	int screen = 0;
	while (1)
	{
		if (screen == 0) //menu
		{
			drawScreen0();
			screen = getInteger();
			continue;
		}
		else if (screen == 1) //add
		{
			drawScreen1();

			Node* newNode = makeNode();
			append(newNode);

			screen = 0;
			continue;
		}
		else if (screen == 2) //show
		{
			showAll();

			screen = 0;
			continue;
		}
		else if (screen == 3) //search
		{
			search();

			screen = 0;
			continue;
		}
		else if(screen == 4) //delete
		{
			deletee();

			screen = 0;
			continue;
		}
		else
		{
			screen = 0;
			continue;
		}
	}

}