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
#include <math.h>

static inline float custom_sin(float angle)
{
	float sin;
	
	asm volatile(".insn r 0xb, 1, 4, %0, %1, x0"
		      : "=r"(sin)
		      : "r"(angle));
		      
	return sin;
}

static inline float custom_cos(float angle)
{
	float cos;
	
	asm volatile(".insn r 0xb, 2, 4, %0, %1, x0"
		      : "=r"(cos)
		      : "r"(angle));
		      
	return cos;
}

int main(void)
{
	float angle1= M_PI/6;
	float angle2 = M_PI/4;
	float a, b, c, d;
	a = custom_sin(angle1);
	b = custom_sin(angle2);
	c = custom_cos(angle1);
	d = custom_cos(angle2);
	
	return a;
}
