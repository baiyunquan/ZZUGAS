#include <ctype.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define IO_LINE_BUF_SIZE 4096

static char io_line_buf[IO_LINE_BUF_SIZE];

static void io_flush_stdout(void)
{
    fflush(stdout);
}

static void io_put_string(const char *s)
{
    fputs(s ? s : "", stdout);
    io_flush_stdout();
}

static void io_put_char(unsigned char ch)
{
    fputc((int)ch, stdout);
    io_flush_stdout();
}

static void io_put_crlf(void)
{
    fputs("\r\n", stdout);
    io_flush_stdout();
}

static void io_put_bits(uint64_t value, unsigned width)
{
    for (unsigned i = width; i > 0; --i) {
        fputc((int)(((value >> (i - 1)) & 1u) + '0'), stdout);
    }
    io_flush_stdout();
}

static void io_put_hex(uint64_t value, unsigned digits)
{
    static const char hex_digits[] = "0123456789ABCDEF";

    for (unsigned i = digits; i > 0; --i) {
        unsigned nibble = (unsigned)((value >> ((i - 1) * 4u)) & 0xFu);
        fputc((int)hex_digits[nibble], stdout);
    }
    io_flush_stdout();
}

static void io_put_u64(uint64_t value)
{
    char buf[32];
    snprintf(buf, sizeof(buf), "%llu", (unsigned long long)value);
    fputs(buf, stdout);
    io_flush_stdout();
}

static void io_put_s64(int64_t value)
{
    char buf[32];
    snprintf(buf, sizeof(buf), "%lld", (long long)value);
    fputs(buf, stdout);
    io_flush_stdout();
}

static char *io_read_line(void)
{
    if (fgets(io_line_buf, sizeof(io_line_buf), stdin) == NULL) {
        io_line_buf[0] = '\0';
        return io_line_buf;
    }

    size_t len = strlen(io_line_buf);
    while (len > 0 && (io_line_buf[len - 1] == '\n' || io_line_buf[len - 1] == '\r')) {
        io_line_buf[--len] = '\0';
    }
    return io_line_buf;
}

static uint64_t io_parse_binary(const char *s)
{
    while (isspace((unsigned char)*s)) {
        ++s;
    }

    if (s[0] == '0' && (s[1] == 'b' || s[1] == 'B')) {
        s += 2;
    }

    uint64_t value = 0;
    int saw_digit = 0;
    while (*s == '0' || *s == '1') {
        saw_digit = 1;
        value = (value << 1) | (uint64_t)(*s - '0');
        ++s;
    }

    return saw_digit ? value : 0;
}

void dispmsg_impl(const char *s)
{
    io_put_string(s);
}

void dispcrlf_impl(void)
{
    io_put_crlf();
}

void dispc_impl(unsigned int ch)
{
    io_put_char((unsigned char)ch);
}

void dispbb_impl(unsigned int value)
{
    io_put_bits((uint64_t)value & 0xFFu, 8);
}

void dispbw_impl(unsigned int value)
{
    io_put_bits((uint64_t)value & 0xFFFFu, 16);
}

void dispbd_impl(unsigned int value)
{
    io_put_bits((uint64_t)value & 0xFFFFFFFFu, 32);
}

void disphb_impl(unsigned int value)
{
    io_put_hex((uint64_t)value & 0xFFu, 2);
}

void disphw_impl(unsigned int value)
{
    io_put_hex((uint64_t)value & 0xFFFFu, 4);
}

void disphd_impl(unsigned int value)
{
    io_put_hex((uint64_t)value & 0xFFFFFFFFu, 8);
}

void disphx_impl(uint64_t value)
{
    io_put_hex(value, 16);
}

void dispuib_impl(unsigned int value)
{
    io_put_u64((uint64_t)value & 0xFFu);
}

void dispuiw_impl(unsigned int value)
{
    io_put_u64((uint64_t)value & 0xFFFFu);
}

void dispuid_impl(unsigned int value)
{
    io_put_u64((uint64_t)value & 0xFFFFFFFFu);
}

void dispsib_impl(int value)
{
    io_put_s64((int8_t)value);
}

void dispsiw_impl(int value)
{
    io_put_s64((int16_t)value);
}

void dispsid_impl(int value)
{
    io_put_s64((int32_t)value);
}

void disprb_impl(uint64_t value)
{
    io_put_hex(value & 0xFFu, 2);
}

void disprw_impl(uint64_t value)
{
    io_put_hex(value & 0xFFFFu, 4);
}

void disprd_impl(uint64_t value)
{
    io_put_hex(value & 0xFFFFFFFFu, 8);
}

void disprf_impl(uint64_t value)
{
    io_put_hex(value, 16);
}

uint64_t readc_impl(void)
{
    int ch = getchar();
    if (ch == EOF) {
        return 0;
    }
    return (uint64_t)(unsigned char)ch;
}

size_t readmsg_impl(char *dest)
{
    if (dest == NULL) {
        return 0;
    }

    char *line = io_read_line();
    size_t len = strlen(line);
    memcpy(dest, line, len + 1);
    return len;
}

uint64_t readbb_impl(void)
{
    return io_parse_binary(io_read_line()) & 0xFFu;
}

uint64_t readbw_impl(void)
{
    return io_parse_binary(io_read_line()) & 0xFFFFu;
}

uint64_t readbd_impl(void)
{
    return io_parse_binary(io_read_line()) & 0xFFFFFFFFu;
}

uint64_t readhb_impl(void)
{
    return strtoull(io_read_line(), NULL, 16) & 0xFFu;
}

uint64_t readhw_impl(void)
{
    return strtoull(io_read_line(), NULL, 16) & 0xFFFFu;
}

uint64_t readhd_impl(void)
{
    return strtoull(io_read_line(), NULL, 16) & 0xFFFFFFFFu;
}

uint64_t readuib_impl(void)
{
    return strtoull(io_read_line(), NULL, 10) & 0xFFu;
}

uint64_t readuiw_impl(void)
{
    return strtoull(io_read_line(), NULL, 10) & 0xFFFFu;
}

uint64_t readuid_impl(void)
{
    return strtoull(io_read_line(), NULL, 10) & 0xFFFFFFFFu;
}

int64_t readsib_impl(void)
{
    return (int8_t)strtoll(io_read_line(), NULL, 10);
}

int64_t readsiw_impl(void)
{
    return (int16_t)strtoll(io_read_line(), NULL, 10);
}

int64_t readsid_impl(void)
{
    return (int32_t)strtoll(io_read_line(), NULL, 10);
}
