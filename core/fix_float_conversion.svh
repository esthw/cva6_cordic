

/***************************  float-fix conversion  ************************************/
`define     FIX32_LEN          32
`define     FIX32INT_LEN       16


`define     FLOAT_LEN          32
`define     M_LEN              23         // mantissa length of float
`define     E_LEN              8          // exponent length of float
`define     S_LEN              1          // sign length of float
`define     E_BIAS             127        // exponent bias

`define     FIX64_LEN          64
`define     FIX64INT_LEN       32

`define     MSB_LEN            6

/****************************************************************************************/




/************************************ sine cosine atan ***************************************/

`define sign_bit 63

`define k       64'd2608131496    	   //  cos(atan(1)) * cos(atan(1/2)) * cos(atan(1/4)) * ... cos(atan(1/(2^n))) * 2^32  

`define rot0    64'd3373259426
`define rot1    64'd1991351318    	     //   atan(1.0)    * 2^32
`define rot2    64'd1052175346    	     //   atan(1.0/2)  * 2^32
`define rot3    64'd534100635    	    //   atan(1.0/4)  * 2^32
`define rot4    64'd268086748    	    //   atan(1.0/8)  * 2^32
`define rot5    64'd134174063    	    //   atan(1.0/16) * 2^32
`define rot6    64'd67103403    	    //   atan(1.0/32) * 2^32
`define rot7    64'd33553749    	    //   atan(1.0/64) * 2^32
`define rot8    64'd16777131    	    //   atan(1.0/128) * 2^32
`define rot9    64'd8388597    	        //   atan(1.0/256) * 2^32
`define rot10   64'd4194303    		   //   atan(1.0/512) * 2^32
`define rot11   64'd2097152    		   //   atan(1.0/1024) * 2^32
`define rot12   64'd1048576			   //   atan(1.0/2048) * 2^32
`define rot13   64'd524288    		    //   atan(1.0/4096) * 2^32
`define rot14   64'd262144    		    //   atan(1.0/8192) * 2^32
`define rot15   64'd131072    		    //   atan(1.0/16384) * 2^32
`define rot16   64'd65536    		    //   atan(1.0/32768) * 2^32




/****************************************************************************************/


/************************************ sinh cosh exp ***************************************/
`define     kh          64'd5176021246    	   //  cosh(atan(1/2)) * cosh(atan(1/4)) * ... cosh(atan(1/(2^n))) * 2^32  

`define     roth0       64'd2359251925           // 0.54930614433405489105  << 32
`define     roth1       64'd1096989674           // 0.25541281188299536087  << 32
`define     roth2       64'd539693625            // 
`define     roth3       64'd268785803            //
`define     roth4       64'd134261444
`define     roth5       64'd67114326
`define     roth6       64'd33555115
`define     roth7       64'd16777301
`define     roth8       64'd8388619
`define     roth9       64'd4194305        //  0.00097656281044103594204  << 32
`define     roth10      64'd2097152        //  0.00048828128880511287736  << 32
`define     roth11      64'd1048576        //  0.00024414062985063860823  << 32
`define     roth12      64'd524288         //  0.00012207031310632981925   << 32
`define     roth13      64'd262144         //  6.103515632579122063e-05    << 32
`define     roth14      64'd131072         //  3.0517578134473900885e-05   << 32
`define     roth15      64'd65536         //  1.5258789063684236764e-05   << 32


/****************************************************************************************/