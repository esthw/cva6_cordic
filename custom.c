/*
**
** Copyright 2020 OpenHW Group
**
** Licensed under the Solderpad Hardware Licence, Version 2.0 (the "License");
** you may not use this file except in compliance with the License.
** You may obtain a copy of the License at
**
**     https://solderpad.org/licenses/
**
** Unless required by applicable law or agreed to in writing, software
** distributed under the License is distributed on an "AS IS" BASIS,
** WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
** See the License for the specific language governing permissions and
** limitations under the License.
**
*/

#include <stdint.h>
#include <stdio.h>
#include "user_define.h"

static inline int custom_sin(int angle)
{
	int sin;
	
	asm volatile(".insn r 0xb, 1, 4, %0, %1, x0"
		      : "=r"(sin)
		      : "r"(angle));
		      
	return sin;
}

int main(void)
{
	int angle=0;
	int a;
	a = custom_sin(angle);
	
	return a;
}
