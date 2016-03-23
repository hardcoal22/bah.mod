/*
 Copyright (c) 2010-2016 Bruce A Henderson
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
*/

#if defined(WIN32) 

#include <winsock2.h>
#include <ws2tcpip.h>
#include <iphlpapi.h>

#elif defined(__APPLE__)

#include <ifaddrs.h>
#include <netinet/in.h>
#include <net/if_dl.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/ioctl.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <arpa/inet.h>

#elif defined(linux)

#include <net/if.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <arpa/inet.h>

#endif

extern "C" {

#include "blitz.h"

	BBArray * bmx_inet_listinterfaces();
}

