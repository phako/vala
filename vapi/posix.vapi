/* posix.vapi
 *
 * Copyright (C) 2008-2009  Jürg Billeter
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA
 * 
 * Author:
 * 	Jürg Billeter <j@bitron.ch>
 */

#if POSIX
[CCode (cname = "bool", cheader_filename = "stdbool.h", default_value = "false")]
[BooleanType]
public struct bool {
}

[CCode (cname = "char", default_value = "\'\\0\'")]
[IntegerType (rank = 2, min = 0, max = 127)]
public struct char {
}

[CCode (cname = "unsigned char", default_value = "\'\\0\'")]
[IntegerType (rank = 3, min = 0, max = 255)]
public struct uchar {
}

[CCode (cname = "int", default_value = "0")]
[IntegerType (rank = 6)]
public struct int {
}

[CCode (cname = "unsigned int", default_value = "0U")]
[IntegerType (rank = 7)]
public struct uint {
}

[CCode (cname = "short", default_value = "0")]
[IntegerType (rank = 4, min = -32768, max = 32767)]
public struct short {
}

[CCode (cname = "unsigned short", default_value = "0U")]
[IntegerType (rank = 5, min = 0, max = 65535)]
public struct ushort {
}

[CCode (cname = "long", default_value = "0L")]
[IntegerType (rank = 8)]
public struct long {
}

[CCode (cname = "unsigned long", default_value = "0UL")]
[IntegerType (rank = 9)]
public struct ulong {
}

[CCode (cname = "size_t", cheader_filename = "sys/types.h", default_value = "0UL")]
[IntegerType (rank = 9)]
public struct size_t {
}

[CCode (cname = "ssize_t", cheader_filename = "sys/types.h", default_value = "0L")]
[IntegerType (rank = 8)]
public struct ssize_t {
}

[CCode (cname = "int8_t", cheader_filename = "stdint.h", default_value = "0")]
[IntegerType (rank = 1, min = -128, max = 127)]
public struct int8 {
}

[CCode (cname = "uint8_t", cheader_filename = "stdint.h", default_value = "0U")]
[IntegerType (rank = 3, min = 0, max = 255)]
public struct uint8 {
}

[CCode (cname = "int16_t", cheader_filename = "stdint.h", default_value = "0")]
[IntegerType (rank = 4, min = -32768, max = 32767)]
public struct int16 {
}

[CCode (cname = "uint16_t", cheader_filename = "stdint.h", default_value = "0U")]
[IntegerType (rank = 5, min = 0, max = 65535)]
public struct uint16 {
}

[CCode (cname = "int32_t", cheader_filename = "stdint.h", default_value = "0")]
[IntegerType (rank = 6)]
public struct int32 {
}

[CCode (cname = "uint32_t", cheader_filename = "stdint.h", default_value = "0U")]
[IntegerType (rank = 7)]
public struct uint32 {
}

[CCode (cname = "int64_t", cheader_filename = "stdint.h", default_value = "0LL")]
[IntegerType (rank = 10)]
public struct int64 {
}

[CCode (cname = "uint64_t", cheader_filename = "stdint.h", default_value = "0ULL")]
[IntegerType (rank = 11)]
public struct uint64 {
}

[CCode (cname = "float", default_value = "0.0F")]
[FloatingType (rank = 1)]
public struct float {
}

[CCode (cname = "double", default_value = "0.0")]
[FloatingType (rank = 2)]
public struct double {
}

[CCode (cheader_filename = "time.h")]
[IntegerType (rank = 8)]
public struct time_t {
	[CCode (cname = "time")]
	public time_t ();
}

[Compact]
[Immutable]
[CCode (cname = "char", const_cname = "const char", copy_function = "strdup", free_function = "free", cheader_filename = "stdlib.h,string.h")]
public class string {
	[CCode (cname="atoi")]
	public int to_int();
	[CCode (cname="atol")]
	public long to_long();
	[CCode (cname="atoll")]
	public int64 to_int64();
	[CCode (cname="strlen")]
	public int len();
}

[CCode (cname="printf", cheader_filename = "stdio.h")]
[PrintfFormat]
public void print (string format,...);

#endif

[CCode (cprefix = "", lower_case_cprefix = "")]
namespace Posix {
	[CCode (cheader_filename = "assert.h")]
	public void assert (bool expression);

	[CCode (cheader_filename = "ctype.h")]
	public bool isalnum (int c);
	[CCode (cheader_filename = "ctype.h")]
	public bool isalpha (int c);
	[CCode (cheader_filename = "ctype.h")]
	public bool isascii (int c);
	[CCode (cheader_filename = "ctype.h")]
	public bool iscntrl (int c);
	[CCode (cheader_filename = "ctype.h")]
	public bool isdigit (int c);
	[CCode (cheader_filename = "ctype.h")]
	public bool isgraph (int c);
	[CCode (cheader_filename = "ctype.h")]
	public bool islower (int c);
	[CCode (cheader_filename = "ctype.h")]
	public bool isprint (int c);
	[CCode (cheader_filename = "ctype.h")]
	public bool ispunct (int c);
	[CCode (cheader_filename = "ctype.h")]
	public bool isspace (int c);
	[CCode (cheader_filename = "ctype.h")]
	public bool isupper (int c);
	[CCode (cheader_filename = "ctype.h")]
	public bool isxdigit (int c);
	[CCode (cheader_filename = "ctype.h")]
	public int toascii (int c);
	[CCode (cheader_filename = "ctype.h")]
	public int tolower (int c);
	[CCode (cheader_filename = "ctype.h")]
	public int toupper (int c);

	[Compact]
	[CCode (cname = "struct dirent", cheader_filename = "dirent.h")]
	public class DirEnt {
		public ino_t d_ino;
		public off_t d_off;
		public ushort d_reclen;
		public char d_type;
		public char d_name[256];
	}

	[Compact]
	[CCode (cname = "DIR", free_function = "closedir", cheader_filename = "dirent.h")]
	public class Dir {
	}

	[CCode (cheader_filename = "dirent.h")]
	public int dirfd (Dir dir);
	[CCode (cheader_filename = "dirent.h")]
	public Dir? opendir (string filename);
	[CCode (cheader_filename = "dirent.h")]
	public Dir? fdopendir (int fd);
	[CCode (cheader_filename = "dirent.h")]
	public unowned DirEnt? readdir (Dir dir);
	[CCode (cheader_filename = "dirent.h")]
	public void rewinddir (Dir dir);
	[CCode (cheader_filename = "dirent.h")]
	public void seekdir (Dir dir, long pos);
	[CCode (cheader_filename = "dirent.h")]
	public long telldir (Dir dir);

	[CCode (cheader_filename = "errno.h")]
	public int errno;
	[CCode (cheader_filename = "errno.h")]
	public const int E2BIG;
	[CCode (cheader_filename = "errno.h")]
	public const int EACCES;
	[CCode (cheader_filename = "errno.h")]
	public const int EADDRINUSE;
	[CCode (cheader_filename = "errno.h")]
	public const int EADDRNOTAVAIL;
	[CCode (cheader_filename = "errno.h")]
	public const int EAFNOSUPPORT;
	[CCode (cheader_filename = "errno.h")]
	public const int EAGAIN;
	[CCode (cheader_filename = "errno.h")]
	public const int EALREADY;
	[CCode (cheader_filename = "errno.h")]
	public const int EBADF;
	[CCode (cheader_filename = "errno.h")]
	public const int EBADMSG;
	[CCode (cheader_filename = "errno.h")]
	public const int EBUSY;
	[CCode (cheader_filename = "errno.h")]
	public const int ECANCELED;
	[CCode (cheader_filename = "errno.h")]
	public const int ECHILD;
	[CCode (cheader_filename = "errno.h")]
	public const int ECONNABORTED;
	[CCode (cheader_filename = "errno.h")]
	public const int ECONNREFUSED;
	[CCode (cheader_filename = "errno.h")]
	public const int ECONNRESET;
	[CCode (cheader_filename = "errno.h")]
	public const int EDEADLK;
	[CCode (cheader_filename = "errno.h")]
	public const int EDESTADDRREQ;
	[CCode (cheader_filename = "errno.h")]
	public const int EDOM;
	[CCode (cheader_filename = "errno.h")]
	public const int EDQUOT;
	[CCode (cheader_filename = "errno.h")]
	public const int EEXIST;
	[CCode (cheader_filename = "errno.h")]
	public const int EFAULT;
	[CCode (cheader_filename = "errno.h")]
	public const int EFBIG;
	[CCode (cheader_filename = "errno.h")]
	public const int EHOSTUNREACH;
	[CCode (cheader_filename = "errno.h")]
	public const int EIDRM;
	[CCode (cheader_filename = "errno.h")]
	public const int EILSEQ;
	[CCode (cheader_filename = "errno.h")]
	public const int EINPROGRESS;
	[CCode (cheader_filename = "errno.h")]
	public const int EINTR;
	[CCode (cheader_filename = "errno.h")]
	public const int EINVAL;
	[CCode (cheader_filename = "errno.h")]
	public const int EIO;
	[CCode (cheader_filename = "errno.h")]
	public const int EISCONN;
	[CCode (cheader_filename = "errno.h")]
	public const int EISDIR;
	[CCode (cheader_filename = "errno.h")]
	public const int ELOOP;
	[CCode (cheader_filename = "errno.h")]
	public const int EMFILE;
	[CCode (cheader_filename = "errno.h")]
	public const int EMLINK;
	[CCode (cheader_filename = "errno.h")]
	public const int EMSGSIZE;
	[CCode (cheader_filename = "errno.h")]
	public const int EMULTIHOP;
	[CCode (cheader_filename = "errno.h")]
	public const int ENAMETOOLONG;
	[CCode (cheader_filename = "errno.h")]
	public const int ENETDOWN;
	[CCode (cheader_filename = "errno.h")]
	public const int ENETRESET;
	[CCode (cheader_filename = "errno.h")]
	public const int ENETUNREACH;
	[CCode (cheader_filename = "errno.h")]
	public const int ENFILE;
	[CCode (cheader_filename = "errno.h")]
	public const int ENOBUFS;
	[CCode (cheader_filename = "errno.h")]
	public const int ENODATA;
	[CCode (cheader_filename = "errno.h")]
	public const int ENODEV;
	[CCode (cheader_filename = "errno.h")]
	public const int ENOENT;
	[CCode (cheader_filename = "errno.h")]
	public const int ENOEXEC;
	[CCode (cheader_filename = "errno.h")]
	public const int ENOLCK;
	[CCode (cheader_filename = "errno.h")]
	public const int ENOLINK;
	[CCode (cheader_filename = "errno.h")]
	public const int ENOMEM;
	[CCode (cheader_filename = "errno.h")]
	public const int ENOMSG;
	[CCode (cheader_filename = "errno.h")]
	public const int ENOPROTOOPT;
	[CCode (cheader_filename = "errno.h")]
	public const int ENOSPC;
	[CCode (cheader_filename = "errno.h")]
	public const int ENOSR;
	[CCode (cheader_filename = "errno.h")]
	public const int ENOSTR;
	[CCode (cheader_filename = "errno.h")]
	public const int ENOSYS;
	[CCode (cheader_filename = "errno.h")]
	public const int ENOTCONN;
	[CCode (cheader_filename = "errno.h")]
	public const int ENOTDIR;
	[CCode (cheader_filename = "errno.h")]
	public const int ENOTEMPTY;
	[CCode (cheader_filename = "errno.h")]
	public const int ENOTSOCK;
	[CCode (cheader_filename = "errno.h")]
	public const int ENOTSUP;
	[CCode (cheader_filename = "errno.h")]
	public const int ENOTTY;
	[CCode (cheader_filename = "errno.h")]
	public const int ENXIO;
	[CCode (cheader_filename = "errno.h")]
	public const int EOPNOTSUPP;
	[CCode (cheader_filename = "errno.h")]
	public const int EOVERFLOW;
	[CCode (cheader_filename = "errno.h")]
	public const int EPERM;
	[CCode (cheader_filename = "errno.h")]
	public const int EPIPE;
	[CCode (cheader_filename = "errno.h")]
	public const int EPROTO;
	[CCode (cheader_filename = "errno.h")]
	public const int EPROTONOSUPPORT;
	[CCode (cheader_filename = "errno.h")]
	public const int EPROTOTYPE;
	[CCode (cheader_filename = "errno.h")]
	public const int ERANGE;
	[CCode (cheader_filename = "errno.h")]
	public const int EROFS;
	[CCode (cheader_filename = "errno.h")]
	public const int ESPIPE;
	[CCode (cheader_filename = "errno.h")]
	public const int ESRCH;
	[CCode (cheader_filename = "errno.h")]
	public const int ESTALE;
	[CCode (cheader_filename = "errno.h")]
	public const int ETIME;
	[CCode (cheader_filename = "errno.h")]
	public const int ETIMEDOUT;
	[CCode (cheader_filename = "errno.h")]
	public const int ETXTBSY;
	[CCode (cheader_filename = "errno.h")]
	public const int EWOULDBLOCK;
	[CCode (cheader_filename = "errno.h")]
	public const int EXDEV;

	[CCode (cheader_filename = "fcntl.h")]
	public const int F_DUPFD;
	[CCode (cheader_filename = "fcntl.h")]
	public const int F_GETFD;
	[CCode (cheader_filename = "fcntl.h")]
	public const int F_SETFD;
	[CCode (cheader_filename = "fcntl.h")]
	public const int F_GETFL;
	[CCode (cheader_filename = "fcntl.h")]
	public const int F_SETFL;
	[CCode (cheader_filename = "fcntl.h")]
	public const int F_GETLK;
	[CCode (cheader_filename = "fcntl.h")]
	public const int F_SETLK;
	[CCode (cheader_filename = "fcntl.h")]
	public const int F_SETLKW;
	[CCode (cheader_filename = "fcntl.h")]
	public const int F_GETOWN;
	[CCode (cheader_filename = "fcntl.h")]
	public const int F_SETOWN;
	[CCode (cheader_filename = "fcntl.h")]
	public const int FD_CLOEXEC;
	[CCode (cheader_filename = "fcntl.h")]
	public const int F_RDLCK;
	[CCode (cheader_filename = "fcntl.h")]
	public const int F_UNLCK;
	[CCode (cheader_filename = "fcntl.h")]
	public const int F_WRLCK;
	[CCode (cheader_filename = "fcntl.h")]
	public const int O_CREAT;
	[CCode (cheader_filename = "fcntl.h")]
	public const int O_EXCL;
	[CCode (cheader_filename = "fcntl.h")]
	public const int O_NOCTTY;
	[CCode (cheader_filename = "fcntl.h")]
	public const int O_TRUNC;
	[CCode (cheader_filename = "fcntl.h")]
	public const int O_APPEND;
	[CCode (cheader_filename = "fcntl.h")]
	public const int O_DSYNC;
	[CCode (cheader_filename = "fcntl.h")]
	public const int O_NONBLOCK;
	[CCode (cheader_filename = "fcntl.h")]
	public const int O_RSYNC;
	[CCode (cheader_filename = "fcntl.h")]
	public const int O_SYNC;
	[CCode (cheader_filename = "fcntl.h")]
	public const int O_ACCMODE;
	[CCode (cheader_filename = "fcntl.h")]
	public const int O_RDONLY;
	[CCode (cheader_filename = "fcntl.h")]
	public const int O_RDWR;
	[CCode (cheader_filename = "fcntl.h")]
	public const int O_WRONLY;
	[CCode (cheader_filename = "fcntl.h")]
	public const int POSIX_FADV_NORMAL;
	[CCode (cheader_filename = "fcntl.h")]
	public const int POSIX_FADV_SEQUENTIAL;
	[CCode (cheader_filename = "fcntl.h")]
	public const int POSIX_FADV_RANDOM;
	[CCode (cheader_filename = "fcntl.h")]
	public const int POSIX_FADV_WILLNEED;
	[CCode (cheader_filename = "fcntl.h")]
	public const int POSIX_FADV_DONTNEED;
	[CCode (cheader_filename = "fcntl.h")]
	public const int POSIX_FADV_NOREUSE;
	[CCode (cheader_filename = "fcntl.h")]
	public int creat (string path, mode_t mode);
	[CCode (cheader_filename = "fcntl.h")]
	public int fcntl (int fd, int cmd, ...);
	[CCode (cheader_filename = "fcntl.h")]
	public int open (string path, int oflag, mode_t mode=0);
	[CCode (cheader_filename = "fcntl.h")]
	public int posix_fadvice (int fd, long offset, long len, int advice);
	[CCode (cheader_filename = "fcntl.h")]
	public int posix_fallocate (int fd, long offset, long len);

	[Compact]
	[CCode (cname = "struct group", cheader_filename = "grp.h")]
	public class Group {
		public string gr_name;
		public string gr_passwd;
		public gid_t gr_gid;
		public string[] gr_mem;
	}
	[CCode (cheader_filename = "grp.h")]
	public void endgrent ();
	public unowned Group? getgrent ();
	public void setgrent ();

	[CCode (cheader_filename = "arpa/inet.h")]
	public uint32 inet_addr (string host);
	[CCode (cheader_filename = "arpa/inet.h")]
	public weak string inet_ntoa (InAddr addr);
	[CCode (cheader_filename = "arpa/inet.h")]
	public uint32 htonl (uint32 hostlong);
	[CCode (cheader_filename = "arpa/inet.h")]
	public uint32 ntohl (uint32 netlong);
	[CCode (cheader_filename = "arpa/inet.h")]
	public uint16 htons (uint16 hostshort);
	[CCode (cheader_filename = "arpa/inet.h")]
	public uint16 ntohs (uint16 netshort);

	[CCode (cheader_filename = "math.h")]
	public double acos (double x);
	[CCode (cheader_filename = "math.h")]
	public float acosf (float x);
	[CCode (cheader_filename = "math.h")]
	public double asin (double x);
	[CCode (cheader_filename = "math.h")]
	public float asinf (float x);
	[CCode (cheader_filename = "math.h")]
	public double atan (double x);
	[CCode (cheader_filename = "math.h")]
	public float atanf (float x);
	[CCode (cheader_filename = "math.h")]
	public double atan2 (double y, double x);
	[CCode (cheader_filename = "math.h")]
	public float atan2f (float y, float x);
	[CCode (cheader_filename = "math.h")]
	public double cos (double x);
	[CCode (cheader_filename = "math.h")]
	public float cosf (float x);
	[CCode (cheader_filename = "math.h")]
	public double sin (double x);
	[CCode (cheader_filename = "math.h")]
	public float sinf (float x);
	[CCode (cheader_filename = "math.h")]
	public double tan (double x);
	[CCode (cheader_filename = "math.h")]
	public float tanf (float x);
	[CCode (cheader_filename = "math.h")]
	public double cosh (double x);
	[CCode (cheader_filename = "math.h")]
	public float coshf (float x);
	[CCode (cheader_filename = "math.h")]
	public double sinh (double x);
	[CCode (cheader_filename = "math.h")]
	public float sinhf (float x);
	[CCode (cheader_filename = "math.h")]
	public double tanh (double x);
	[CCode (cheader_filename = "math.h")]
	public float tanhf (float x);
	[CCode (cheader_filename = "math.h")]
	public void sincos (double x, out double sinx, out double cosx);
	[CCode (cheader_filename = "math.h")]
	public void sincosf (float x, out float sinx, out float cosx);
	[CCode (cheader_filename = "math.h")]
	public double acosh (double x);
	[CCode (cheader_filename = "math.h")]
	public float acoshf (float x);
	[CCode (cheader_filename = "math.h")]
	public double asinh (double x);
	[CCode (cheader_filename = "math.h")]
	public float asinhf (float x);
	[CCode (cheader_filename = "math.h")]
	public double atanh (double x);
	[CCode (cheader_filename = "math.h")]
	public float atanhf (float x);
	[CCode (cheader_filename = "math.h")]
	public double exp (double x);
	[CCode (cheader_filename = "math.h")]
	public float expf (float x);
	[CCode (cheader_filename = "math.h")]
	public double frexp (double x, out int exponent);
	[CCode (cheader_filename = "math.h")]
	public float frexpf (float x, out int exponent);
	[CCode (cheader_filename = "math.h")]
	public double ldexp (double x, int exponent);
	[CCode (cheader_filename = "math.h")]
	public float ldexpf (float x, int exponent);
	[CCode (cheader_filename = "math.h")]
	public double log (double x);
	[CCode (cheader_filename = "math.h")]
	public float logf (float x);
	[CCode (cheader_filename = "math.h")]
	public double log10 (double x);
	[CCode (cheader_filename = "math.h")]
	public float log10f (float x);
	[CCode (cheader_filename = "math.h")]
	public double modf (double x, out double iptr);
	[CCode (cheader_filename = "math.h")]
	public float modff (float x, out float iptr);
	[CCode (cheader_filename = "math.h")]
	public double exp10 (double x);
	[CCode (cheader_filename = "math.h")]
	public float exp10f (float x);
	[CCode (cheader_filename = "math.h")]
	public double pow10 (double x);
	[CCode (cheader_filename = "math.h")]
	public float pow10f (float x);
	[CCode (cheader_filename = "math.h")]
	public double expm1 (double x);
	[CCode (cheader_filename = "math.h")]
	public float expm1f (float x);
	[CCode (cheader_filename = "math.h")]
	public double log1p (double x);
	[CCode (cheader_filename = "math.h")]
	public float log1pf (float x);
	[CCode (cheader_filename = "math.h")]
	public double logb (double x);
	[CCode (cheader_filename = "math.h")]
	public float logbf (float x);
	[CCode (cheader_filename = "math.h")]
	public double exp2 (double x);
	[CCode (cheader_filename = "math.h")]
	public float exp2f (float x);
	[CCode (cheader_filename = "math.h")]
	public double log2 (double x);
	[CCode (cheader_filename = "math.h")]
	public float log2f (float x);
	[CCode (cheader_filename = "math.h")]
	public double pow (double x, double y);
	[CCode (cheader_filename = "math.h")]
	public float powf (float x, float y);
	[CCode (cheader_filename = "math.h")]
	public double sqrt (double x);
	[CCode (cheader_filename = "math.h")]
	public float sqrtf (float x);
	[CCode (cheader_filename = "math.h")]
	public double hypot (double x, double y);
	[CCode (cheader_filename = "math.h")]
	public float hypotf (float x, float y);
	[CCode (cheader_filename = "math.h")]
	public double cbrt (double x);
	[CCode (cheader_filename = "math.h")]
	public float cbrtf (float x);
	[CCode (cheader_filename = "math.h")]
	public double ceil (double x);
	[CCode (cheader_filename = "math.h")]
	public float ceilf (float x);
	[CCode (cheader_filename = "math.h")]
	public double fabs (double x);
	[CCode (cheader_filename = "math.h")]
	public float fabsf (float x);
	[CCode (cheader_filename = "math.h")]
	public double floor (double x);
	[CCode (cheader_filename = "math.h")]
	public float floorf (float x);
	[CCode (cheader_filename = "math.h")]
	public double fmod (double x, double y);
	[CCode (cheader_filename = "math.h")]
	public float fmodf (float x, float y);
	[CCode (cheader_filename = "math.h")]
	public int isinf (double value);
	[CCode (cheader_filename = "math.h")]
	public int isinff (float value);
	[CCode (cheader_filename = "math.h")]
	public int finite (double value);
	[CCode (cheader_filename = "math.h")]
	public int finitef (float value);
	[CCode (cheader_filename = "math.h")]
	public double drem (double x, double y);
	[CCode (cheader_filename = "math.h")]
	public float dremf (float x, float y);
	[CCode (cheader_filename = "math.h")]
	public double significand (double x);
	[CCode (cheader_filename = "math.h")]
	public float significandf (float x);
	[CCode (cheader_filename = "math.h")]
	public double copysign (double x, double y);
	[CCode (cheader_filename = "math.h")]
	public float copysignf (float x, float y);
	[CCode (cheader_filename = "math.h")]
	public double nan (string tagb);
	[CCode (cheader_filename = "math.h")]
	public float nanf (string tagb);
	[CCode (cheader_filename = "math.h")]
	public int isnan (double value);
	[CCode (cheader_filename = "math.h")]
	public int isnanf (float value);
	[CCode (cheader_filename = "math.h")]
	public double j0 (double x0);
	[CCode (cheader_filename = "math.h")]
	public float j0f (float x0);
	[CCode (cheader_filename = "math.h")]
	public double j1 (double x0);
	[CCode (cheader_filename = "math.h")]
	public float j1f (float x0);
	[CCode (cheader_filename = "math.h")]
	public double jn (int x0, double x1);
	[CCode (cheader_filename = "math.h")]
	public float jnf (int x0, float x1);
	[CCode (cheader_filename = "math.h")]
	public double y0 (double x0);
	[CCode (cheader_filename = "math.h")]
	public float y0f (float x0);
	[CCode (cheader_filename = "math.h")]
	public double y1 (double x0);
	[CCode (cheader_filename = "math.h")]
	public float y1f (float x0);
	[CCode (cheader_filename = "math.h")]
	public double yn (int x0, double x1);
	[CCode (cheader_filename = "math.h")]
	public float ynf (int x0, float x1);
	[CCode (cheader_filename = "math.h")]
	public double erf (double x0);
	[CCode (cheader_filename = "math.h")]
	public float erff (float x0);
	[CCode (cheader_filename = "math.h")]
	public double erfc (double x0);
	[CCode (cheader_filename = "math.h")]
	public float erfcf (float x0);
	[CCode (cheader_filename = "math.h")]
	public double lgamma (double x0);
	[CCode (cheader_filename = "math.h")]
	public float lgammaf (float x0);
	[CCode (cheader_filename = "math.h")]
	public double tgamma (double x0);
	[CCode (cheader_filename = "math.h")]
	public float tgammaf (float x0);
	[CCode (cheader_filename = "math.h")]
	public double gamma (double x0);
	[CCode (cheader_filename = "math.h")]
	public float gammaf (float x0);
	[CCode (cheader_filename = "math.h")]
	public double lgamma_r (double x0, out int signgamp);
	[CCode (cheader_filename = "math.h")]
	public float lgamma_rf (float x0, out int signgamp);
	[CCode (cheader_filename = "math.h")]
	public double rint (double x);
	[CCode (cheader_filename = "math.h")]
	public float rintf (float x);
	[CCode (cheader_filename = "math.h")]
	public double nextafter (double x, double y);
	[CCode (cheader_filename = "math.h")]
	public float nextafterf (float x, float y);
	[CCode (cheader_filename = "math.h")]
	public double nexttoward (double x, double y);
	[CCode (cheader_filename = "math.h")]
	public float nexttowardf (float x, double y);
	[CCode (cheader_filename = "math.h")]
	public double remainder (double x, double y);
	[CCode (cheader_filename = "math.h")]
	public float remainderf (float x, float y);
	[CCode (cheader_filename = "math.h")]
	public double scalbn (double x, int n);
	[CCode (cheader_filename = "math.h")]
	public float scalbnf (float x, int n);
	[CCode (cheader_filename = "math.h")]
	public int ilogb (double x);
	[CCode (cheader_filename = "math.h")]
	public int ilogbf (float x);
	[CCode (cheader_filename = "math.h")]
	public double scalbln (double x, long n);
	[CCode (cheader_filename = "math.h")]
	public float scalblnf (float x, long n);
	[CCode (cheader_filename = "math.h")]
	public double nearbyint (double x);
	[CCode (cheader_filename = "math.h")]
	public float nearbyintf (float x);
	[CCode (cheader_filename = "math.h")]
	public double round (double x);
	[CCode (cheader_filename = "math.h")]
	public float roundf (float x);
	[CCode (cheader_filename = "math.h")]
	public double trunc (double x);
	[CCode (cheader_filename = "math.h")]
	public float truncf (float x);
	[CCode (cheader_filename = "math.h")]
	public double remquo (double x, double y, out int quo);
	[CCode (cheader_filename = "math.h")]
	public float remquof (float x, float y, out int quo);
	[CCode (cheader_filename = "math.h")]
	public long lrint (double x);
	[CCode (cheader_filename = "math.h")]
	public long lrintf (float x);
	[CCode (cheader_filename = "math.h")]
	public int64 llrint (double x);
	[CCode (cheader_filename = "math.h")]
	public int64 llrintf (float x);
	[CCode (cheader_filename = "math.h")]
	public long lround (double x);
	[CCode (cheader_filename = "math.h")]
	public long lroundf (float x);
	[CCode (cheader_filename = "math.h")]
	public int64 llround (double x);
	[CCode (cheader_filename = "math.h")]
	public int64 llroundf (float x);
	[CCode (cheader_filename = "math.h")]
	public double fdim (double x, double y);
	[CCode (cheader_filename = "math.h")]
	public float fdimf (float x, float y);
	[CCode (cheader_filename = "math.h")]
	public double fmax (double x, double y);
	[CCode (cheader_filename = "math.h")]
	public float fmaxf (float x, float y);
	[CCode (cheader_filename = "math.h")]
	public double fmin (double x, double y);
	[CCode (cheader_filename = "math.h")]
	public float fminf (float x, float y);
	[CCode (cheader_filename = "math.h")]
	public double fma (double x, double y, double z);
	[CCode (cheader_filename = "math.h")]
	public float fmaf (float x, float y, float z);
	[CCode (cheader_filename = "math.h")]
	public double scalb (double x, double n);
	[CCode (cheader_filename = "math.h")]
	public float scalbf (float x, float n);

	[CCode (cheader_filename = "poll.h", cname = "struct pollfd")]
	public struct pollfd {
		public int fd;
		public int events;
		public int revents;
	}

	[CCode (cheader_filename = "poll.h")]
	public const int POLLIN;
	[CCode (cheader_filename = "poll.h")]
	public const int POLLPRI;
	[CCode (cheader_filename = "poll.h")]
	public const int POLLOUT;
	[CCode (cheader_filename = "poll.h")]
	public const int POLLRDHUP;
	[CCode (cheader_filename = "poll.h")]
	public const int POLLERR;
	[CCode (cheader_filename = "poll.h")]
	public const int POLLHUP;
	[CCode (cheader_filename = "poll.h")]
	public const int POLLNVAL;

	[SimpleType]
	[IntegerType (rank = 9)]
	[CCode (cheader_filename = "poll.h", cname = "nfds_t")]
	public struct nfds_t {
	}

	[CCode (cheader_filename = "poll.h")]
	public int poll (pollfd fds, nfds_t nfds, int timeout);
	[CCode (cheader_filename = "poll.h")]
	public int ppoll (pollfd fds, nfds_t nfds, timespec? timeout, sigset_t? sigmask);

	[Compact]
	[CCode (cname = "struct passwd", cheader_filename = "pwd.h")]
	public class Passwd {
		public string pw_name;
		public string pw_passwd;
		public uid_t pw_uid;
		public gid_t pw_gid;
		public string pw_gecos;
		public string pw_dir;
		public string pw_shell;
	}
	[CCode (cheader_filename = "pwd.h")]
	public void endpwent ();
	public unowned Passwd? getpwent ();
	public void setpwent ();

	[CCode (cheader_filename = "sys/resource.h")]
	public const int PRIO_PROCESS;
	[CCode (cheader_filename = "sys/resource.h")]
	public const int PRIO_PGRP;
	[CCode (cheader_filename = "sys/resource.h")]
	public const int PRIO_USER;

	[CCode (cheader_filename = "signal.h")]
	public const int SIGABRT;
	[CCode (cheader_filename = "signal.h")]
	public const int SIGALRM;
	[CCode (cheader_filename = "signal.h")]
	public const int SIGBUS;
	[CCode (cheader_filename = "signal.h")]
	public const int SIGCHLD;
	[CCode (cheader_filename = "signal.h")]
	public const int SIGCONT;
	[CCode (cheader_filename = "signal.h")]
	public const int SIGFPE;
	[CCode (cheader_filename = "signal.h")]
	public const int SIGHUP;
	[CCode (cheader_filename = "signal.h")]
	public const int SIGILL;
	[CCode (cheader_filename = "signal.h")]
	public const int SIGINT;
	[CCode (cheader_filename = "signal.h")]
	public const int SIGKILL;
	[CCode (cheader_filename = "signal.h")]
	public const int SIGPIPE;
	[CCode (cheader_filename = "signal.h")]
	public const int SIGQUIT;
	[CCode (cheader_filename = "signal.h")]
	public const int SIGSEGV;
	[CCode (cheader_filename = "signal.h")]
	public const int SIGSTOP;
	[CCode (cheader_filename = "signal.h")]
	public const int SIGTERM;
	[CCode (cheader_filename = "signal.h")]
	public const int SIGTSTP;
	[CCode (cheader_filename = "signal.h")]
	public const int SIGTTIN;
	[CCode (cheader_filename = "signal.h")]
	public const int SIGTTOU;
	[CCode (cheader_filename = "signal.h")]
	public const int SIGUSR1;
	[CCode (cheader_filename = "signal.h")]
	public const int SIGUSR2;
	[CCode (cheader_filename = "signal.h")]
	public const int SIGPOLL;
	[CCode (cheader_filename = "signal.h")]
	public const int SIGPROF;
	[CCode (cheader_filename = "signal.h")]
	public const int SIGSYS;
	[CCode (cheader_filename = "signal.h")]
	public const int SIGTRAP;
	[CCode (cheader_filename = "signal.h")]
	public const int SIGURG;
	[CCode (cheader_filename = "signal.h")]
	public const int SIGVTALRM;
	[CCode (cheader_filename = "signal.h")]
	public const int SIGXCPU;
	[CCode (cheader_filename = "signal.h")]
	public const int SIGXFSZ;
	[CCode (cheader_filename = "signal.h")]
	public const int SIGIOT;
	[CCode (cheader_filename = "signal.h")]
	public const int SIGSTKFLT;

	[SimpleType]
	[IntegerType (rank = 6)]
	[CCode (cname = "pid_t", default_value = "0", cheader_filename = "sys/types.h")]
	public struct pid_t {
	}
	[CCode (cheader_filename = "signal.h")]
	public int kill (pid_t pid, int signum);
	[CCode (cheader_filename = "signal.h")]
	public int killpg (pid_t pgpr, int signum);
	[CCode (cheader_filename = "signal.h")]
	public int raise (int signum);
	[CCode (cheader_filename = "signal.h")]
	public int sigemptyset (sigset_t sigset);
	[CCode (cheader_filename = "signal.h")]
	public int sigfillset (sigset_t sigset);
	[CCode (cheader_filename = "signal.h")]
	public int sigaddset (sigset_t sigset, int signo);
	[CCode (cheader_filename = "signal.h")]
	public int sigdelset (sigset_t sigset, int __signo);
	[CCode (cheader_filename = "signal.h")]
	public int sigismember (sigset_t sigset, int __signo);
	[CCode (cheader_filename = "signal.h")]
	public int sigprocmask (int how, sigset_t sigset, sigset_t oset);
	[CCode (cheader_filename = "signal.h")]
	public int sigsuspend (sigset_t sigset);
	[CCode (cheader_filename = "signal.h")]
	public int sigpending (sigset_t sigset);
	[CCode (cheader_filename = "signal.h")]
	public int sigwait (sigset_t sigset, out int sig);

	[CCode (cheader_filename = "signal.h")]
	public static delegate void sighandler_t (int signal);

	[CCode (cheader_filename = "signal.h")]
	public sighandler_t SIG_DFL;

	[CCode (cheader_filename = "signal.h")]
	public sighandler_t SIG_ERR;

	[CCode (cheader_filename = "signal.h")]
	public sighandler_t SIG_IGN;

	[CCode (cheader_filename = "signal.h")]
	public sighandler_t signal (int signum, sighandler_t? handler);

	[CCode (cheader_filename = "stdio.h")]
	[PrintfFormat]
	public void printf (string format,...);

	[CCode (cheader_filename = "stdlib.h")]
	public void abort ();
	[CCode (cheader_filename = "stdlib.h")]
	public void exit (int status);

	[CCode (cheader_filename = "stdlib.h")]
	public void _exit (int status);

	public delegate void AtExitFunc ();

	[CCode (cheader_filename = "stdlib.h")]
	public void atexit (AtExitFunc func);

	[CCode (cheader_filename = "stdlib.h")]
	public int mkstemp (string template);

	[CCode (cheader_filename = "stdlib.h")]
	public int mkostemp (string template, int flags);

	[CCode (cheader_filename = "stdlib.h")]
	public int posix_openpt (int flags);
	[CCode (cheader_filename = "stdlib.h")]
	public int grantpt (int fd);
	[CCode (cheader_filename = "stdlib.h")]
	public int unlockpt (int fd);

	[CCode (cheader_filename = "stdlib.h")]
	public int system (string command);

	public static delegate int compar_fn_t (void* key1, void* key2);

	[CCode (cheader_filename = "stdlib.h")]
	public void* bsearch (void* key, void* base, size_t nmemb, size_t size, compar_fn_t func);

	[CCode (cheader_filename = "stdlib.h")]
	public void qsort (void* base, size_t nmemb, size_t size, compar_fn_t func);

	[CCode (cheader_filename = "stdlib.h")]
	public void qsort_r (void* base, size_t nmemb, size_t size, compar_fn_t func, void* arg);

	[CCode (cheader_filename = "stdlib.h")]
	public const int EXIT_FAILURE;
	[CCode (cheader_filename = "stdlib.h")]
	public const int EXIT_SUCCESS;

	[CCode (cheader_filename = "string.h")]
	public void* memccpy (void* s1, void* s2, int c, size_t n);
	[CCode (cheader_filename = "string.h")]
	public void* memchr (void* s, int c, size_t n);
	[CCode (cheader_filename = "string.h")]
	public int memcmp (void* s1, void* s2, size_t n);
	[CCode (cheader_filename = "string.h")]
	public void* memcpy (void* s1, void* s2, size_t n);
	[CCode (cheader_filename = "string.h")]
	public void* memmove (void* s1, void* s2, size_t n);
	[CCode (cheader_filename = "string.h")]
	public void* memset (void* s, int c, size_t n);
	[CCode (cheader_filename = "string.h")]
	public unowned string strcat (string s1, string s2);
	[CCode (cheader_filename = "string.h")]
	public unowned string strchr (string s, int c);
	[CCode (cheader_filename = "string.h")]
	public int strcmp (string s1, string s2);
	[CCode (cheader_filename = "string.h")]
	public int strcoll (string s1, string s2);
	[CCode (cheader_filename = "string.h")]
	public unowned string strcpy (string s1, string s2);
	[CCode (cheader_filename = "string.h")]
	public size_t strcspn (string s1, string s2);
	[CCode (cheader_filename = "string.h")]
	public unowned string strdup (string s1);
	[CCode (cheader_filename = "string.h")]
	public unowned string strerror (int errnum);
	[CCode (cheader_filename = "string.h")]
	public int* strerror_r (int errnum, string strerrbuf, size_t buflen);
	[CCode (cheader_filename = "string.h")]
	public size_t strlen (string s);
	[CCode (cheader_filename = "string.h")]
	public unowned string strncat (string s1, string s2, size_t n);
	[CCode (cheader_filename = "string.h")]
	public int strncmp (string s1, string s2, size_t n);
	[CCode (cheader_filename = "string.h")]
	public unowned string strncpy (string s1, string s2, size_t n);
	[CCode (cheader_filename = "string.h")]
	public unowned string strpbrk (string s1, string s2);
	[CCode (cheader_filename = "string.h")]
	public unowned string strrchr (string s, int c);
	[CCode (cheader_filename = "string.h")]
	public size_t strspn (string s1, string s2);
	[CCode (cheader_filename = "string.h")]
	public unowned string strstr (string s1, string s2);
	[CCode (cheader_filename = "string.h")]
	public unowned string strtok (string s1, string s2);
	[CCode (cheader_filename = "string.h")]
	public unowned string strtok_r (string s, string sep, out string lasts);
	[CCode (cheader_filename = "string.h")]
	public size_t strxfrm (string s1, string s2, size_t n);

	[CCode (cheader_filename = "stropts.h")]
	public const int I_PUSH;
	[CCode (cheader_filename = "stropts.h")]
	public const int I_POP;
	[CCode (cheader_filename = "stropts.h")]
	public const int I_LOOK;
	[CCode (cheader_filename = "stropts.h")]
	public const int I_FLUSH;
	[CCode (cheader_filename = "stropts.h")]
	public const int I_FLUSHBAND;
	[CCode (cheader_filename = "stropts.h")]
	public const int I_SETSIG;
	[CCode (cheader_filename = "stropts.h")]
	public const int I_GETSIG;
	[CCode (cheader_filename = "stropts.h")]
	public const int I_FIND;
	[CCode (cheader_filename = "stropts.h")]
	public const int I_PEEK;
	[CCode (cheader_filename = "stropts.h")]
	public const int I_SRDOPT;
	[CCode (cheader_filename = "stropts.h")]
	public const int I_GRDOPT;
	[CCode (cheader_filename = "stropts.h")]
	public const int I_NREAD;
	[CCode (cheader_filename = "stropts.h")]
	public const int I_FDINSERT;
	[CCode (cheader_filename = "stropts.h")]
	public const int I_STR;
	[CCode (cheader_filename = "stropts.h")]
	public const int I_SWROPT;
	[CCode (cheader_filename = "stropts.h")]
	public const int I_GWROPT;
	[CCode (cheader_filename = "stropts.h")]
	public const int I_SENDFD;
	[CCode (cheader_filename = "stropts.h")]
	public const int I_RECVFD;
	[CCode (cheader_filename = "stropts.h")]
	public const int I_LIST;
	[CCode (cheader_filename = "stropts.h")]
	public const int I_ATMARK;
	[CCode (cheader_filename = "stropts.h")]
	public const int I_CKBAND;
	[CCode (cheader_filename = "stropts.h")]
	public const int I_GETBAND;
	[CCode (cheader_filename = "stropts.h")]
	public const int I_CANPUT;
	[CCode (cheader_filename = "stropts.h")]
	public const int I_SETCLTIME;
	[CCode (cheader_filename = "stropts.h")]
	public const int I_GETCLTIME;
	[CCode (cheader_filename = "stropts.h")]
	public const int I_LINK;
	[CCode (cheader_filename = "stropts.h")]
	public const int I_UNLINK;
	[CCode (cheader_filename = "stropts.h")]
	public const int I_PLINK;
	[CCode (cheader_filename = "stropts.h")]
	public const int I_PUNLINK;
	[CCode (cheader_filename = "stropts.h")]
	public const int FLUSHR;
	[CCode (cheader_filename = "stropts.h")]
	public const int FLUSHW;
	[CCode (cheader_filename = "stropts.h")]
	public const int FLUSHRW;
	[CCode (cheader_filename = "stropts.h")]
	public const int S_RDNORM;
	[CCode (cheader_filename = "stropts.h")]
	public const int S_RDBAND;
	[CCode (cheader_filename = "stropts.h")]
	public const int S_INPUT;
	[CCode (cheader_filename = "stropts.h")]
	public const int S_HIPRI;
	[CCode (cheader_filename = "stropts.h")]
	public const int S_OUTPUT;
	[CCode (cheader_filename = "stropts.h")]
	public const int S_WRNORM;
	[CCode (cheader_filename = "stropts.h")]
	public const int S_WRBAND;
	[CCode (cheader_filename = "stropts.h")]
	public const int S_MSG;
	[CCode (cheader_filename = "stropts.h")]
	public const int S_ERROR;
	[CCode (cheader_filename = "stropts.h")]
	public const int S_HANGUP;
	[CCode (cheader_filename = "stropts.h")]
	public const int S_BANDURG;
	[CCode (cheader_filename = "stropts.h")]
	public const int RS_HIPRI;
	[CCode (cheader_filename = "stropts.h")]
	public const int RNORM;
	[CCode (cheader_filename = "stropts.h")]
	public const int RMSGD;
	[CCode (cheader_filename = "stropts.h")]
	public const int RMSGN;
	[CCode (cheader_filename = "stropts.h")]
	public const int RPROTNORN;
	[CCode (cheader_filename = "stropts.h")]
	public const int RPROTDAT;
	[CCode (cheader_filename = "stropts.h")]
	public const int RPROTDIS;
	[CCode (cheader_filename = "stropts.h")]
	public const int SNDZERO;
	[CCode (cheader_filename = "stropts.h")]
	public const int ANYMARK;
	[CCode (cheader_filename = "stropts.h")]
	public const int LASTMARK;
	[CCode (cheader_filename = "stropts.h")]
	public const int MUXID_ALL;
	[CCode (cheader_filename = "stropts.h")]
	public const int MSG_ANY;
	[CCode (cheader_filename = "stropts.h")]
	public const int MSG_BAND;
	[CCode (cheader_filename = "stropts.h")]
	public const int MSG_HIPRI;
	[CCode (cheader_filename = "stropts.h")]
	public const int MORECTL;
	[CCode (cheader_filename = "stropts.h")]
	public const int MOREDATA;
	[CCode (cheader_filename = "stropts.h", sentinel = "")]
	public int ioctl (int fildes, int request, ...);

	[CCode (cheader_filename = "syslog.h")]
	public void openlog (string ident, int option, int facility );

	[CCode (cheader_filename = "syslog.h")]
	public void syslog (int priority, string format, ... );

	[CCode (cheader_filename = "syslog.h")]
	public void closelog ();

	[CCode (cheader_filename = "syslog.h")]
	public const int LOG_PID;
	[CCode (cheader_filename = "syslog.h")]
	public const int LOG_CONS;
	[CCode (cheader_filename = "syslog.h")]
	public const int LOG_ODELAY;
	[CCode (cheader_filename = "syslog.h")]
	public const int LOG_NDELAY;
	[CCode (cheader_filename = "syslog.h")]
	public const int LOG_NOWAIT;
	[CCode (cheader_filename = "syslog.h")]
	public const int LOG_EMERG;
	[CCode (cheader_filename = "syslog.h")]
	public const int LOG_ALERT;
	[CCode (cheader_filename = "syslog.h")]
	public const int LOG_CRIT;
	[CCode (cheader_filename = "syslog.h")]
	public const int LOG_ERR;
	[CCode (cheader_filename = "syslog.h")]
	public const int LOG_WARNING;
	[CCode (cheader_filename = "syslog.h")]
	public const int LOG_NOTICE;
	[CCode (cheader_filename = "syslog.h")]
	public const int LOG_INFO;
	[CCode (cheader_filename = "syslog.h")]
	public const int LOG_DEBUG;
	[CCode (cheader_filename = "syslog.h")]
	public const int LOG_KERN;
	[CCode (cheader_filename = "syslog.h")]
	public const int LOG_USER;
	[CCode (cheader_filename = "syslog.h")]
	public const int LOG_MAIL;
	[CCode (cheader_filename = "syslog.h")]
	public const int LOG_DAEMON;
	[CCode (cheader_filename = "syslog.h")]
	public const int LOG_SYSLOG;
	[CCode (cheader_filename = "syslog.h")]
	public const int LOG_LPR;
	[CCode (cheader_filename = "syslog.h")]
	public const int LOG_NEWS;
	[CCode (cheader_filename = "syslog.h")]
	public const int LOG_UUCP;
	[CCode (cheader_filename = "syslog.h")]
	public const int LOG_CRON;
	[CCode (cheader_filename = "syslog.h")]
	public const int LOG_AUTHPRIV;
	[CCode (cheader_filename = "syslog.h")]
	public const int LOG_FTP;
	[CCode (cheader_filename = "syslog.h")]
	public const int LOG_LOCAL0;
	[CCode (cheader_filename = "syslog.h")]
	public const int LOG_LOCAL1;
	[CCode (cheader_filename = "syslog.h")]
	public const int LOG_LOCAL2;
	[CCode (cheader_filename = "syslog.h")]
	public const int LOG_LOCAL3;
	[CCode (cheader_filename = "syslog.h")]
	public const int LOG_LOCAL4;
	[CCode (cheader_filename = "syslog.h")]
	public const int LOG_LOCAL5;
	[CCode (cheader_filename = "syslog.h")]
	public const int LOG_LOCAL6;
	[CCode (cheader_filename = "syslog.h")]
	public const int LOG_LOCAL7;

	[CCode (cheader_filename = "sys/socket.h")]
	public const int SOCK_DGRAM;
	[CCode (cheader_filename = "sys/socket.h")]
	public const int SOCK_RAW;
	[CCode (cheader_filename = "sys/socket.h")]
	public const int SOCK_SEQPACKET;
	[CCode (cheader_filename = "sys/socket.h")]
	public const int SOCK_STREAM;
	[CCode (cheader_filename = "sys/socket.h")]
	public const int AF_INET;
	[CCode (cheader_filename = "sys/socket.h")]
	public const int AF_INET6;
	[CCode (cheader_filename = "sys/socket.h")]
	public const int AF_UNIX;
	[CCode (cheader_filename = "sys/socket.h", sentinel = "")]
	public int accept (int sfd, ... );
	[CCode (cheader_filename = "sys/socket.h", sentinel = "")]
	public int bind (int sockfd, ...);
	[CCode (cheader_filename = "sys/socket.h",  sentinel = "")]
	public int connect(int sfd, ... );
	[CCode (cheader_filename = "sys/socket.h")]
	public int listen (int sfd, int backlog);
	[CCode (cheader_filename = "sys/socket.h")]
	public int socket (int domain, int type, int protocol);

	[CCode (cheader_filename = "sys/socket.h")]
	public int socketpair (int domain, int type, int protocol, int[] sv);

	[SimpleType]
	[CCode (cname = "struct in_addr", cheader_filename = "sys/socket.h", destroy_function = "")]
	public struct InAddr {
		public uint32 s_addr;
	}

	[CCode (cname = "struct sock_addr", cheader_filename = "sys/socket.h", destroy_function = "")]
	public struct SockAddr {
	}

	[CCode (cheader_filename = "sys/stat.h")]
	public int mkfifo (string filename, mode_t mode);

	[CCode (cheader_filename = "sys/stat.h")]
	public const mode_t S_IFMT;
	[CCode (cheader_filename = "sys/stat.h")]
	public const mode_t S_IFBLK;
	[CCode (cheader_filename = "sys/stat.h")]
	public const mode_t S_IFCHR;
	[CCode (cheader_filename = "sys/stat.h")]
	public const mode_t S_IFIFO;
	[CCode (cheader_filename = "sys/stat.h")]
	public const mode_t S_IFREG;
	[CCode (cheader_filename = "sys/stat.h")]
	public const mode_t S_IFDIR;
	[CCode (cheader_filename = "sys/stat.h")]
	public const mode_t S_IFLNK;
	[CCode (cheader_filename = "sys/stat.h")]
	public const mode_t S_IFSOCK;

	[CCode (cheader_filename = "sys/stat.h")]
	public const mode_t S_IRWXU;
	[CCode (cheader_filename = "sys/stat.h")]
	public const mode_t S_IRUSR;
	[CCode (cheader_filename = "sys/stat.h")]
	public const mode_t S_IWUSR;
	[CCode (cheader_filename = "sys/stat.h")]
	public const mode_t S_IXUSR;
	[CCode (cheader_filename = "sys/stat.h")]
	public const mode_t S_IRWXG;
	[CCode (cheader_filename = "sys/stat.h")]
	public const mode_t S_IRGRP;
	[CCode (cheader_filename = "sys/stat.h")]
	public const mode_t S_IWGRP;
	[CCode (cheader_filename = "sys/stat.h")]
	public const mode_t S_IXGRP;
	[CCode (cheader_filename = "sys/stat.h")]
	public const mode_t S_IRWXO;
	[CCode (cheader_filename = "sys/stat.h")]
	public const mode_t S_IROTH;
	[CCode (cheader_filename = "sys/stat.h")]
	public const mode_t S_IWOTH;
	[CCode (cheader_filename = "sys/stat.h")]
	public const mode_t S_IXOTH;
	[CCode (cheader_filename = "sys/stat.h")]
	public const mode_t S_ISUID;
	[CCode (cheader_filename = "sys/stat.h")]
	public const mode_t S_ISGID;
	[CCode (cheader_filename = "sys/stat.h")]
	public const mode_t S_ISVTX;

	[CCode (cheader_filename = "sys/stat.h")]
	public bool S_ISBLK (mode_t mode);
	[CCode (cheader_filename = "sys/stat.h")]
	public bool S_ISCHR (mode_t mode);
	[CCode (cheader_filename = "sys/stat.h")]
	public bool S_ISDIR (mode_t mode);
	[CCode (cheader_filename = "sys/stat.h")]
	public bool S_ISFIFO (mode_t mode);
	[CCode (cheader_filename = "sys/stat.h")]
	public bool S_ISREG (mode_t mode);
	[CCode (cheader_filename = "sys/stat.h")]
	public bool S_ISLNK (mode_t mode);
	[CCode (cheader_filename = "sys/stat.h")]
	public bool S_ISSOCK (mode_t mode);

	[CCode (cheader_filename = "sys/stat.h", cname = "struct stat")]
	public struct Stat {
		public dev_t st_dev;
		public ino_t st_ino;
		public mode_t st_mode;
		public nlink_t st_nlink;
		public uid_t st_uid;
		public gid_t st_gid;
		public dev_t st_rdev;
		public size_t st_size;
		public time_t st_atime;
		public time_t st_mtime;
		public time_t st_ctime;
		public blksize_t st_blksize;
		public blkcnt_t st_blocks;
	}
	[CCode (cheader_filename = "sys/stat.h")]
	int fstat( int fd, out Stat buf);
	[CCode (cheader_filename = "sys/stat.h")]
	int stat (string filename, out Stat buf);

	[CCode (cheader_filename = "sys/stat.h")]
	public int chmod (string filename, mode_t mode);
	[CCode (cheader_filename = "sys/stat.h")]
	public mode_t umask (mode_t mask);
	[CCode (cheader_filename = "sys/stat.h")]
	public int mkdir (string path, mode_t mode);
	[CCode (cheader_filename = "sys/types.h,sys/stat.h,fcntl.h,unistd.h")]
	public pid_t mknod (string pathname, mode_t mode, dev_t dev);

	[CCode (cheader_filename = "sys/wait.h")]
	public pid_t wait (out int status);
	[CCode (cheader_filename = "sys/wait.h")]
	public pid_t waitpid (pid_t pid, out int status, int options);
	[CCode (cheader_filename = "sys/wait.h")]
	public const int WNOHANG;
	[CCode (cheader_filename = "sys/wait.h")]
	public const int WUNTRACED;
	[CCode (cheader_filename = "sys/wait.h")]
	public const int WCONTINUED;

	[SimpleType]
	[IntegerType (rank = 9)]
	[CCode (cheader_filename = "sys/types.h", cname = "key_t")]
	public struct key_t {
	}

	[SimpleType]
	[IntegerType (rank = 9)]
	[CCode (cheader_filename = "sys/statvfs.h")]
	public struct fsblkcnt_t {
	}

	[SimpleType]
	[IntegerType (rank = 9)]
	[CCode (cheader_filename = "sys/statvfs.h")]
	public struct fsfilcnt_t {
	}

	[CCode (cheader_filename = "sys/statvfs.h", cname = "struct statvfs")]
	public struct statvfs {
		public ulong f_bsize;
		public ulong f_frsize;
		public fsblkcnt_t f_blocks;
		public fsblkcnt_t f_bfree;
		public fsblkcnt_t f_bavail;
		public fsfilcnt_t f_files;
		public fsfilcnt_t f_ffree;
		public fsfilcnt_t f_favail;
	}

	[SimpleType]
	[IntegerType (rank = 9)]
	[CCode (cname="off_t", cheader_filename = "sys/types.h")]
	public struct off_t {
	}

	[SimpleType]
	[IntegerType (rank = 9)]
	[CCode (cheader_filename = "sys/types.h")]
	public struct uid_t {
	}

	[SimpleType]
	[IntegerType (rank = 9)]
	[CCode (cheader_filename = "sys/types.h")]
	public struct gid_t {
	}

	[SimpleType]
	[IntegerType (rank = 9)]
	[CCode (cname = "mode_t", cheader_filename = "sys/types.h")]
	public struct mode_t {
	}

	[SimpleType]
	[IntegerType (rank = 9)]
	[CCode (cheader_filename = "sys/types.h")]
	public struct dev_t {
	}

	[SimpleType]
	[IntegerType (rank = 9)]
	[CCode (cheader_filename = "sys/types.h")]
	public struct ino_t {
	}

	[SimpleType]
	[IntegerType (rank = 9)]
	[CCode (cheader_filename = "sys/types.h")]
	public struct nlink_t {
	}

	[SimpleType]
	[IntegerType (rank = 9)]
	[CCode (cheader_filename = "sys/types.h")]
	public struct blksize_t {
	}

	[SimpleType]
	[IntegerType (rank = 9)]
	[CCode (cheader_filename = "sys/types.h")]
	public struct blkcnt_t {
	}

	[CCode (cheader_filename = "time.h")]
	public struct tm {
		public int tm_sec;
		public int tm_min;
		public int tm_hour;
		public int tm_mday;
		public int tm_mon;
		public int tm_year;
		public int tm_wday;
		public int tm_yday;
		public int tm_isdst;
	}

	[CCode (cheader_filename = "time.h")]
	public struct timespec {
		public time_t tv_sec;
		public long tv_nsec;
	}

	[CCode (cheader_filename = "sys/time.h,sys/resource.h")]
	public int getpriority (int which, int who);
	[CCode (cheader_filename = "sys/time.h,sys/resource.h")]
	public int setpriority (int which, int who, int prio);

	[CCode (cheader_filename = "unistd.h")]
	public int close (int fd);
	[CCode (cheader_filename = "unistd.h")]
	public int execl (string path, params string[] arg);
	[CCode (cheader_filename = "unistd.h")]
	public int pipe ([CCode (array_length = false, null_terminated = false)] int[] pipefd);
	[CCode (cheader_filename = "unistd.h")]
	public ssize_t read (int fd, void* buf, size_t count);
	[CCode (cheader_filename = "unistd.h")]
	public ssize_t readlink (string path, char[] buf);
	[CCode (cheader_filename = "unistd.h,sys/types.h")]
	public int setgid (gid_t gid);
	[CCode (cheader_filename = "unistd.h,sys/types.h")]
	public int setuid (uid_t uid);
	[CCode (cheader_filename = "unistd.h")]
	public int unlink (string filename);
	[CCode (cheader_filename = "unistd.h")]
	public ssize_t write (int fd, void* buf, size_t count);
	[CCode (cheader_filename = "unistd.h")]
	public off_t lseek(int fildes, off_t offset, int whence);

	[CCode (cheader_filename = "unistd.h")]
	public const int SEEK_SET;
	[CCode (cheader_filename = "unistd.h")]
	public const int SEEK_CUR;
	[CCode (cheader_filename = "unistd.h")]
	public const int SEEK_END;

	[CCode (cheader_filename = "unistd.h")]
	public pid_t fork ();
	[CCode (cheader_filename = "unistd.h")]
	public pid_t vfork ();
	[CCode (cheader_filename = "unistd.h")]
	public unowned string ttyname (int fd);
	[CCode (cheader_filename = "unistd.h")]
	public int ttyname_r (int fd, char[] buf);
	[CCode (cheader_filename = "unistd.h")]
	public bool isatty (int fd);
	[CCode (cheader_filename = "unistd.h")]
	public int link (string from, string to);
	[CCode (cheader_filename = "unistd.h")]
	public int symlink (string from, string to);
	[CCode (cheader_filename = "unistd.h")]
	public int rmdir (string path);
	[CCode (cheader_filename = "unistd.h")]
	public pid_t tcgetpgrp (int fd);
	[CCode (cheader_filename = "unistd.h")]
	public int tcsetpgrp (int fd, pid_t pgrp_id);
	[CCode (cheader_filename = "unistd.h")]
	public unowned string getlogin ();
	[CCode (cheader_filename = "unistd.h")]
	public int vhangup ();
	[CCode (cheader_filename = "unistd.h")]
	public int revoke (string file);
	[CCode (cheader_filename = "unistd.h")]
	public int acct (string name);
	[CCode (cheader_filename = "unistd.h")]
	public unowned string getusershell ();
	[CCode (cheader_filename = "unistd.h")]
	public void endusershell ();
	[CCode (cheader_filename = "unistd.h")]
	public void setusershell ();
	[CCode (cheader_filename = "unistd.h")]
	public int chroot (string path);
	[CCode (cheader_filename = "unistd.h")]
	public unowned string getpass (string promt);
	[CCode (cheader_filename = "unistd.h")]
	public int getpagesize ();
	[CCode (cheader_filename = "unistd.h")]
	public int getdtablesize ();

	[CCode (cheader_filename = "unistd.h")]
	public const int STDIN_FILENO;
	[CCode (cheader_filename = "unistd.h")]
	public const int STDOUT_FILENO;
	[CCode (cheader_filename = "unistd.h")]
	public const int STDERR_FILENO;
	[CCode (cheader_filename = "unistd.h")]
	public const int R_OK;
	[CCode (cheader_filename = "unistd.h")]
	public const int W_OK;
	[CCode (cheader_filename = "unistd.h")]
	public const int X_OK;
	[CCode (cheader_filename = "unistd.h")]
	public const int F_OK;

	[CCode (cheader_filename = "unistd.h")]
	public int access (string patchname, int mode);
	[CCode (cheader_filename = "unistd.h")]
	public int euidaccess (string patchname, int mode);
	[CCode (cheader_filename = "unistd.h")]
	public int eaccess (string patchname, int mode);

	[CCode (cheader_filename = "unistd.h")]
	public uint alarm (uint seconds);
	[CCode (cheader_filename = "unistd.h")]
	public uint ualarm (uint useconds);
	[CCode (cheader_filename = "unistd.h")]
	public uint sleep (uint seconds);
	[CCode (cheader_filename = "unistd.h")]
	public uint usleep (uint useconds);
	[CCode (cheader_filename = "unistd.h")]
	public int pause ();
	[CCode (cheader_filename = "unistd.h")]
	public int chown (string filename, uid_t owner, gid_t group);
	[CCode (cheader_filename = "unistd.h")]
	public int fchown (int fd, uid_t owner, gid_t group);
	[CCode (cheader_filename = "unistd.h")]
	public int lchown (string filename, uid_t owner, gid_t group);
	[CCode (cheader_filename = "unistd.h")]
	public int chdir (string filepath);
	[CCode (cheader_filename = "unistd.h")]
	public int fchdir (int file);
	[CCode (cheader_filename = "unistd.h")]
	public int dup (int fd);
	[CCode (cheader_filename = "unistd.h")]
	public int dup2 (int fd1, int fd2);
	[CCode (cheader_filename = "unistd.h")]
	public pid_t getpid ();
	[CCode (cheader_filename = "unistd.h")]
	public pid_t getppid ();
	[CCode (cheader_filename = "unistd.h")]
	public pid_t getpgrp ();
	[CCode (cheader_filename = "unistd.h")]
	public pid_t getpgid (pid_t pid);
	[CCode (cheader_filename = "unistd.h")]
	public int setpgid (pid_t pid, pid_t pgid);
	[CCode (cheader_filename = "unistd.h")]
	public pid_t setpgrp ();
	[CCode (cheader_filename = "unistd.h")]
	public pid_t getsid (pid_t pid);
	[CCode (cheader_filename = "unistd.h")]
	public uid_t getuid ();
	[CCode (cheader_filename = "unistd.h")]
	public uid_t geteuid ();
	[CCode (cheader_filename = "unistd.h")]
	public gid_t getgid ();
	[CCode (cheader_filename = "unistd.h")]
	public gid_t getegid ();
	[CCode (cheader_filename = "unistd.h")]
	public int group_member (gid_t gid);
	[CCode (cheader_filename = "unistd.h")]
	public pid_t setsid ();
	[CCode (cheader_filename = "unistd.h")]
	public pid_t tcgetsid (int fd);

	[CCode (cheader_filename = "unistd.h")]
	public int fsync (int fd);
	[CCode (cheader_filename = "unistd.h")]
	public int fdatasync (int fd);
	[CCode (cheader_filename = "unistd.h")]
	public int sync ();

	[CCode (cheader_filename = "unistd.h")]
	public int ftruncate(int fd, off_t length);
	[CCode (cheader_filename = "unistd.h")]
	public int truncate(string path, off_t length);
	[CCode (cheader_filename = "unistd.h")]
	public int nice (int inc);

	[SimpleType]
	[CCode (cname = "cc_t", cheader_filename = "termios.h")]
	[IntegerType (rank = 3, min = 0, max = 255)]
	public struct cc_t {
	}

	[SimpleType]
	[CCode (cname = "speed_t", cheader_filename = "termios.h")]
	[IntegerType (rank = 7)]
	public struct speed_t {
	}

	[SimpleType]
	[CCode (cname = "tcflag_t", cheader_filename = "termios.h")]
	[IntegerType (rank = 7)]
	public struct tcflag_t {
	}

	[CCode (cname="struct termios", cheader_filename = "termios.h")]
	public struct termios
	{
		public tcflag_t c_iflag;
		public tcflag_t c_oflag;
		public tcflag_t c_cflag;
		public tcflag_t c_lflag;
		public cc_t c_line;
		public unowned cc_t[] c_cc;
		public speed_t c_ispeed;
		public speed_t c_ospeed;
	}

	[CCode (cheader_filename = "termios.h")]
	public int tcgetattr (int fd, termios termios_p);
	[CCode (cheader_filename = "termios.h")]
	public int tcsetattr (int fd, int optional_actions, termios termios_p);
	[CCode (cheader_filename = "termios.h")]
	public int tcsendbreak (int fd, int duration);
	[CCode (cheader_filename = "termios.h")]
	public int tcdrain (int fd);
	[CCode (cheader_filename = "termios.h")]
	public int tcflush (int fd, int queue_selector);
	[CCode (cheader_filename = "termios.h")]
	public int tcflow (int fd, int action);
	[CCode (cheader_filename = "termios.h")]
	public void cfmakeraw (termios termios_p);
	[CCode (cheader_filename = "termios.h")]
	public speed_t cfgetispeed (termios termios_p);
	[CCode (cheader_filename = "termios.h")]
	public speed_t cfgetospeed (termios termios_p);
	[CCode (cheader_filename = "termios.h")]
	public int cfsetispeed (termios termios_p, speed_t speed);
	[CCode (cheader_filename = "termios.h")]
	public int cfsetospeed (termios termios_p, speed_t speed);
	[CCode (cheader_filename = "termios.h")]
	public int cfsetspeed (termios termios, speed_t speed);

	//c_iflag
	[CCode (cheader_filename = "termios.h")]
	public const tcflag_t IGNBRK;
	[CCode (cheader_filename = "termios.h")]
	public const tcflag_t BRKINT;
	[CCode (cheader_filename = "termios.h")]
	public const tcflag_t IGNPAR;
	[CCode (cheader_filename = "termios.h")]
	public const tcflag_t PARMRK;
	[CCode (cheader_filename = "termios.h")]
	public const tcflag_t INPCK;
	[CCode (cheader_filename = "termios.h")]
	public const tcflag_t ISTRIP;
	[CCode (cheader_filename = "termios.h")]
	public const tcflag_t INLCR;
	[CCode (cheader_filename = "termios.h")]
	public const tcflag_t IGNCR;
	[CCode (cheader_filename = "termios.h")]
	public const tcflag_t IXON;
	[CCode (cheader_filename = "termios.h")]
	public const tcflag_t IXANY;
	[CCode (cheader_filename = "termios.h")]
	public const tcflag_t IXOFF;
	[CCode (cheader_filename = "termios.h")]
	public const tcflag_t ICRNL;

	//c_oflag
	[CCode (cheader_filename = "termios.h")]
	public const tcflag_t OPOST;
	[CCode (cheader_filename = "termios.h")]
	public const tcflag_t ONLCR;
	[CCode (cheader_filename = "termios.h")]
	public const tcflag_t OCRNL;
	[CCode (cheader_filename = "termios.h")]
	public const tcflag_t ONOCR;
	[CCode (cheader_filename = "termios.h")]
	public const tcflag_t ONLRET;
	[CCode (cheader_filename = "termios.h")]
	public const tcflag_t OFILL;
	[CCode (cheader_filename = "termios.h")]
	public const tcflag_t NLDLY;
	[CCode (cheader_filename = "termios.h")]
	public const tcflag_t NL0;
	[CCode (cheader_filename = "termios.h")]
	public const tcflag_t NL1;
	[CCode (cheader_filename = "termios.h")]
	public const tcflag_t CRDLY;
	[CCode (cheader_filename = "termios.h")]
	public const tcflag_t CR0;
	[CCode (cheader_filename = "termios.h")]
	public const tcflag_t CR1;
	[CCode (cheader_filename = "termios.h")]
	public const tcflag_t CR2;
	[CCode (cheader_filename = "termios.h")]
	public const tcflag_t CR3;
	[CCode (cheader_filename = "termios.h")]
	public const tcflag_t TABDLY;
	[CCode (cheader_filename = "termios.h")]
	public const tcflag_t TAB0;
	[CCode (cheader_filename = "termios.h")]
	public const tcflag_t TAB1;
	[CCode (cheader_filename = "termios.h")]
	public const tcflag_t TAB2;
	[CCode (cheader_filename = "termios.h")]
	public const tcflag_t TAB3;
	[CCode (cheader_filename = "termios.h")]
	public const tcflag_t BSDLY;
	[CCode (cheader_filename = "termios.h")]
	public const tcflag_t BS0;
	[CCode (cheader_filename = "termios.h")]
	public const tcflag_t BS1;
	[CCode (cheader_filename = "termios.h")]
	public const tcflag_t VTDLY;
	[CCode (cheader_filename = "termios.h")]
	public const tcflag_t VT0;
	[CCode (cheader_filename = "termios.h")]
	public const tcflag_t VT1;
	[CCode (cheader_filename = "termios.h")]
	public const tcflag_t FFDLY;
	[CCode (cheader_filename = "termios.h")]
	public const tcflag_t FF0;
	[CCode (cheader_filename = "termios.h")]
	public const tcflag_t FF1;

	//c_cflag
	[CCode (cheader_filename = "termios.h")]
	public const tcflag_t CSIZE;
	[CCode (cheader_filename = "termios.h")]
	public const tcflag_t CS5;
	[CCode (cheader_filename = "termios.h")]
	public const tcflag_t CS6;
	[CCode (cheader_filename = "termios.h")]
	public const tcflag_t CS7;
	[CCode (cheader_filename = "termios.h")]
	public const tcflag_t CS8;
	[CCode (cheader_filename = "termios.h")]
	public const tcflag_t CSTOPB;
	[CCode (cheader_filename = "termios.h")]
	public const tcflag_t CREAD;
	[CCode (cheader_filename = "termios.h")]
	public const tcflag_t PARENB;
	[CCode (cheader_filename = "termios.h")]
	public const tcflag_t PARODD;
	[CCode (cheader_filename = "termios.h")]
	public const tcflag_t HUPCL;
	[CCode (cheader_filename = "termios.h")]
	public const tcflag_t CLOCAL;

	//c_lflag
	[CCode (cheader_filename = "termios.h")]
	public const tcflag_t ISIG;
	[CCode (cheader_filename = "termios.h")]
	public const tcflag_t ICANON;
	[CCode (cheader_filename = "termios.h")]
	public const tcflag_t ECHO;
	[CCode (cheader_filename = "termios.h")]
	public const tcflag_t ECHOE;
	[CCode (cheader_filename = "termios.h")]
	public const tcflag_t ECHOK;
	[CCode (cheader_filename = "termios.h")]
	public const tcflag_t ECHONL;
	[CCode (cheader_filename = "termios.h")]
	public const tcflag_t NOFLSH;
	[CCode (cheader_filename = "termios.h")]
	public const tcflag_t TOSTOP;
	[CCode (cheader_filename = "termios.h")]
	public const tcflag_t IEXTEN;

	//c_cc indexes
	[CCode (cheader_filename = "termios.h")]
	public const int VINTR;
	[CCode (cheader_filename = "termios.h")]
	public const int VQUIT;
	[CCode (cheader_filename = "termios.h")]
	public const int VERASE;
	[CCode (cheader_filename = "termios.h")]
	public const int VKILL;
	[CCode (cheader_filename = "termios.h")]
	public const int VEOF;
	[CCode (cheader_filename = "termios.h")]
	public const int VMIN;
	[CCode (cheader_filename = "termios.h")]
	public const int VEOL;
	[CCode (cheader_filename = "termios.h")]
	public const int VTIME;
	[CCode (cheader_filename = "termios.h")]
	public const int VSTART;
	[CCode (cheader_filename = "termios.h")]
	public const int VSTOP;
	[CCode (cheader_filename = "termios.h")]
	public const int VSUSP;

	//optional_actions
	[CCode (cheader_filename = "termios.h")]
	public const int TCSANOW;
	[CCode (cheader_filename = "termios.h")]
	public const int TCSADRAIN;
	[CCode (cheader_filename = "termios.h")]
	public const int TCSAFLUSH;

	//queue_selector
	[CCode (cheader_filename = "termios.h")]
	public const int TCIFLUSH;
	[CCode (cheader_filename = "termios.h")]
	public const int TCOFLUSH;
	[CCode (cheader_filename = "termios.h")]
	public const int TCIOFLUSH;

	//action
	[CCode (cheader_filename = "termios.h")]
	public const int TCOOFF;
	[CCode (cheader_filename = "termios.h")]
	public const int TCOON;
	[CCode (cheader_filename = "termios.h")]
	public const int TCIOFF;
	[CCode (cheader_filename = "termios.h")]
	public const int TCION;

	//speed
	[CCode (cheader_filename = "termios.h")]
	public const speed_t B0;
	[CCode (cheader_filename = "termios.h")]
	public const speed_t B50;
	[CCode (cheader_filename = "termios.h")]
	public const speed_t B75;
	[CCode (cheader_filename = "termios.h")]
	public const speed_t B110;
	[CCode (cheader_filename = "termios.h")]
	public const speed_t B134;
	[CCode (cheader_filename = "termios.h")]
	public const speed_t B150;
	[CCode (cheader_filename = "termios.h")]
	public const speed_t B200;
	[CCode (cheader_filename = "termios.h")]
	public const speed_t B300;
	[CCode (cheader_filename = "termios.h")]
	public const speed_t B600;
	[CCode (cheader_filename = "termios.h")]
	public const speed_t B1200;
	[CCode (cheader_filename = "termios.h")]
	public const speed_t B1800;
	[CCode (cheader_filename = "termios.h")]
	public const speed_t B2400;
	[CCode (cheader_filename = "termios.h")]
	public const speed_t B4800;
	[CCode (cheader_filename = "termios.h")]
	public const speed_t B9600;
	[CCode (cheader_filename = "termios.h")]
	public const speed_t B19200;
	[CCode (cheader_filename = "termios.h")]
	public const speed_t B38400;
	[CCode (cheader_filename = "termios.h")]
	public const speed_t B57600;
	[CCode (cheader_filename = "termios.h")]
	public const speed_t B115200;
	[CCode (cheader_filename = "termios.h")]
	public const speed_t B230400;

	[CCode (cname = "fd_set", cheader_filename = "sys/select.h")]
	public struct fd_set {
	}

	[CCode (cname = "struct timeval", cheader_filename = "sys/time.h")]
	public struct timeval {
		public time_t tv_sec;
		public long tv_usec;
		[CCode (cname = "gettimeofday")]
		public int get_time_of_day (void * timezone = null);
		[CCode (cname = "settimeofday")]
		public int set_time_of_day (void * timezone = null);
	}

	[CCode (cname = "sigset_t", cheader_filename = "sys/select.h")]
	public struct sigset_t {
	}

	[CCode (cheader_filename = "sys/select.h")]
	public int select (int nfds, fd_set? readfds, fd_set? writefds, fd_set? exceptfds, timeval timeout);
	[CCode (cheader_filename = "sys/select.h")]
	public void FD_CLR (int fd, fd_set @set);
	[CCode (cheader_filename = "sys/select.h")]
	public int  FD_ISSET (int fd, fd_set @set);
	[CCode (cheader_filename = "sys/select.h")]
	public void FD_SET (int fd, fd_set @set);
	[CCode (cheader_filename = "sys/select.h")]
	public void FD_ZERO (fd_set @set);
	[CCode (cheader_filename = "sys/select.h")]
	public int pselect (int nfds, fd_set? readfds, fd_set? writefds, fd_set? exceptfds, timespec timeout, sigset_t sigmask);

	// sys/mman.h - Posix mmap(), munmap(), mprotect()
	[CCode (cheader_filename = "sys/mman.h")]
	public void *mmap(void *addr, size_t length, int prot, int flags, int fd, off_t offset);
	[CCode (cheader_filename = "sys/mman.h")]
	public int munmap(void *addr, size_t length);
	[CCode (cheader_filename = "sys/mman.h")]
	public int mprotect(void *addr, size_t len, int prot);
	[CCode (cheader_filename = "sys/mman.h")]
	public const int PROT_READ;
	[CCode (cheader_filename = "sys/mman.h")]
	public const int PROT_WRITE;
	[CCode (cheader_filename = "sys/mman.h")]
	public const int PROT_EXEC;
	[CCode (cheader_filename = "sys/mman.h")]
	public const int MAP_SHARED;
	[CCode (cheader_filename = "sys/mman.h")]
	public const int MAP_PRIVATE;
	[CCode (cheader_filename = "sys/mman.h")]
	public const int MAP_FIXED;
	[CCode (cheader_filename = "sys/mman.h")]
	public void *MAP_FAILED;
	// sys/mman.h - [MLR] Range Memory Locking
	[CCode (cheader_filename = "sys/mman.h")]
	public int mlock(void *addr, size_t len);
	[CCode (cheader_filename = "sys/mman.h")]
	public int munlock(void *addr, size_t len);
	// sys/mman.h - [XSI] X/Open System Interfaces
	[CCode (cheader_filename = "sys/mman.h")]
	public int msync(void *addr, size_t len, int flags);
	[CCode (cheader_filename = "sys/mman.h")]
	public const int MS_ASYNC;
	[CCode (cheader_filename = "sys/mman.h")]
	public const int MS_INVALIDATE;
	[CCode (cheader_filename = "sys/mman.h")]
	public const int MS_SYNC;

	[Compact]
	[CCode (cname = "FILE", free_function = "fclose", cheader_filename = "stdio.h")]
	public class FILE {
		[CCode (cname = "EOF", cheader_filename = "stdio.h")]
		public const int EOF;
		[CCode (cname = "SEEK_SET", cheader_filename = "stdio.h")]
		public const int SEEK_SET;
		[CCode (cname = "SEEK_CUR", cheader_filename = "stdio.h")]
		public const int SEEK_CUR;
		[CCode (cname = "SEEK_END", cheader_filename = "stdio.h")]
		public const int SEEK_END;

		[CCode (cname = "fopen")]
		public static FILE? open (string path, string mode);
		[CCode (cname = "fdopen")]
		public static FILE? fdopen (int fildes, string mode);
		[CCode (cname = "popen")]
		public static FILE? popen (string command, string mode);

		[CCode (cname = "fprintf")]
		[PrintfFormat ()]
		public void printf (string format, ...);
		[CCode (cname = "fputc", instance_pos = -1)]
		public void putc (char c);
		[CCode (cname = "fputs", instance_pos = -1)]
		public void puts (string s);
		[CCode (cname = "fgetc")]
		public int getc ();
		[CCode (cname = "fgets", instance_pos = -1)]
		public weak string gets (char[] s);
		[CCode (cname = "feof")]
		public bool eof ();
		[CCode (cname = "fscanf"), ScanfFormat]
		public int scanf (string format, ...);
		[CCode (cname = "fflush")]
		public int flush ();
		[CCode (cname = "fseek")]
		public int seek (long offset, int whence);
		[CCode (cname = "ftell")]
		public long tell ();
		[CCode (cname = "rewind")]
		public void rewind ();
		[CCode (cname = "fileno")]
		public int fileno ();
		[CCode (cname = "ferror")]
		public int error ();
		[CCode (cname = "clearerr")]
		public void clearerr ();
	}

	public static FILE stderr;
	public static FILE stdout;
	public static FILE stdin;
}

