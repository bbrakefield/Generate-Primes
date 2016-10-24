#include <windows.h>
#include <stdio.h>
#include "resource.h" 

static char buf[255];
static char inputLabel[255];

#pragma warning(disable : 4996)
// disables warning for strcpy use

void getInput(char* inputPrompt, char* result, int maxChars)
// generate an input dialog with prompt as a label
// and a text box to input a string of up to maxChars characters,
// returned in result
{
	char *temp = (char *) malloc(maxChars * sizeof(char));
	printf(inputPrompt);
	scanf("%s", temp);
	temp[maxChars - 1] = '\0';
	strcpy(result, temp);
	return;
}

void showOutput(char* outputLabel, char* outputString)
// display a message box with outputLabel in the title bar
// and outputString in the main area
{
	printf(outputLabel);
	printf(outputString);
	return;
}

int MainProc(void);
// prototype for user's main program

int WINAPI WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance,
	LPSTR lpCmdLine, int nCmdShow)
{
	AllocConsole();
	freopen("CONIN$" , "rb", stdin);
	freopen("CONOUT$" , "wb", stdout);

	return MainProc();
}


