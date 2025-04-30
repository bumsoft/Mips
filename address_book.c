#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <malloc.h>

/*
	mips: 12bytes
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
		//else if (screen == 3) //search
		//{

		//	screen = 0;
		//	continue;
		//}
		//else //delete
		//{

		//	screen = 0;
		//	continue;
		//}
	}

}