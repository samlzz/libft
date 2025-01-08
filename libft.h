/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   libft.h                                            :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: sliziard <sliziard@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/11/05 11:54:22 by sliziard          #+#    #+#             */
/*   Updated: 2025/01/08 19:31:32 by sliziard         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef LIBFT_H
# define LIBFT_H

# include <stddef.h>

/**
 * @struct s_mem
 * @brief Represents a memory table with content and size.
 */
typedef struct s_mem
{
	char	*content; /**< Pointer to the content. */
	size_t	size; /**< Size of the content. */
}	t_mem;

//* ft_is
/**
 * @brief Checks if a character is alphabetic.
 * @param c The character to check.
 * @return 1 if the character is alphabetic, 0 otherwise.
 */
int				ft_isalpha(int c);

/**
 * @brief Checks if a character is a digit.
 * @param c The character to check.
 * @return 1 if the character is a digit, 0 otherwise.
 */
int				ft_isdigit(int c);

/**
 * @brief Checks if a character is alphanumeric.
 * @param c The character to check.
 * @return 1 if the character is alphanumeric, 0 otherwise.
 */
int				ft_isalnum(int c);

/**
 * @brief Checks if a character is an ASCII character.
 * @param c The character to check.
 * @return 1 if the character is an ASCII character, 0 otherwise.
 */
int				ft_isascii(int c);

/**
 * @brief Checks if a character is printable.
 * @param c The character to check.
 * @return 1 if the character is printable, 0 otherwise.
 */
int				ft_isprint(int c);

//* ft_char
/**
 * @brief Converts a lowercase letter to uppercase.
 * @param c The character to convert.
 * @return The uppercase equivalent of the character if it's lowercase,
 *         otherwise the character itself.
 */
int				ft_toupper(int c);

/**
 * @brief Converts an uppercase letter to lowercase.
 * @param c The character to convert.
 * @return The lowercase equivalent of the character if it's uppercase,
 *         otherwise the character itself.
 */
int				ft_tolower(int c);

/**
 * @brief Finds the first occurrence of a character in a string.
 * @param s The string to search.
 * @param c The character to find.
 * @return A pointer to the first occurrence of the character in the string, 
 *         or `NULL` if not found.
 */
char			*ft_strchr(const char *s, int c);

/**
 * @brief Finds the last occurrence of a character in a string.
 * @param s The string to search.
 * @param c The character to find.
 * @return A pointer to the last occurrence of the character in the string,
 *         or `NULL` if not found.
 */
char			*ft_strrchr(const char *s, int c);

//* ft_str
/**
 * @brief Calculates the length of a string.
 * @param str The string to measure.
 * @return The number of characters in the string, excluding the null terminator.
 */
size_t			ft_strlen(const char *str);

/**
 * @brief Concatenates two strings with a size limit.
 * This function appends the NUL-terminated string src to the end of dst.
 * It will append at most `size` - `strlen(dst)` - 1 bytes,
 * NUL-terminating the result.
 * 
 * @param dst The destination buffer.
 * @param src The source string to append.
 * @param size The total size of the destination buffer.
 * @return The total length of the string it tried to create.
 */
size_t			ft_strlcat(char *dst, const char *src, size_t size);

/**
 * @brief Copies a string to a destination buffer with a size limit.
 * This function copies up to size - 1 characters from the NUL-terminated
 * string src to dst, NUL-terminating the result.
 * 
 * @param dst The destination buffer.
 * @param src The source string to copy.
 * @param size The total size of the destination buffer.
 * @return The length of the source string.
 */
size_t			ft_strlcpy(char *dst, const char *src, size_t size);

/**
 * @brief Compares two strings up to a given number of characters.
 * @param s1 The first string.
 * @param s2 The second string.
 * @param n The maximum number of characters to compare.
 * @return 
 *	- 0, if the s1 and s2 are equal

 *	- a negative value if s1 is less than s2
 
 *	- a positive value if s1 is greater than s2.
 */
int				ft_strncmp(const char *s1, const char *s2, size_t n);

/**
 * @brief Finds a substring in a string within a specified length.
 * @param big The string to search.
 * @param little The substring to find.
 * @param len The maximum number of characters to search.
 * @return A pointer to the start of the substring, or `NULL` if not found.
 */
char			*ft_strnstr(const char *big, const char *little, size_t len);

//? alloc
/**
 * @brief Duplicates a string by allocating memory.
 * @param s The string to duplicate.
 * @return
 * A pointer to the newly allocated string, or `NULL` if allocation fails.
 */
char			*ft_strdup(const char *s);

/**
 * @brief Extracts a substring from a string.
 * @param s The source string.
 * @param start The starting index of the substring.
 * @param len The length of the substring to extract.
 * @return
 * A pointer to the newly allocated substring, or `NULL` if allocation fails.
 */
char			*ft_substr(char const *s, unsigned int start, size_t len);

/**
 * @brief Joins two strings into a new allocated string.
 * @param s1 The first string.
 * @param s2 The second string.
 * @return
 * A pointer to the newly allocated string, or `NULL` if allocation fails.
 */
char			*ft_strjoin(char const *s1, char const *s2);

/**
 * @brief Trims characters from the beginning and end of a string.
 * @param s1 The source string.
 * @param set The set of characters to trim.
 * @return A pointer to the newly allocated trimmed string,
 * or `NULL` if allocation fails.
 */
char			*ft_strtrim(char const *s1, char const *set);

//? iter
/**
 * @brief Applies a function to each character of a string to create 
 * a new string.
 * @param s The input string.
 * @param f The function to apply to each character.
 * @return A pointer to the newly allocated string resulting from 
 * the application of `f`.
 */
char			*ft_strmapi(char const *s, char (*f) (unsigned int, char));

/**
 * @brief Applies a function to each character of a string in-place.
 * @param s The input string.
 * @param f The function to apply to each character.
 */
void			ft_striteri(char *s, void (*f) (unsigned int, char *));

//? split
/**
 * @brief Splits a string into an array of strings using a delimiter.
 * @param s The string to split.
 * @param c The delimiter character.
 * @return A pointer to the newly allocated array of strings, or
 * `NULL` if allocation fails.
 */
char			**ft_split(char const *s, char c);

//* ft_mem
/**
 * @brief Fills a memory area with a constant byte.
 *
 * Writes `n` bytes of the value `c` (converted to unsigned char) to the memory
 * area pointed to by `s`.
 *
 * @param s The memory area to fill.
 * @param c The value to set.
 * @param n The number of bytes to write.
 * @return A pointer to the memory area `s`.
 */
void			*ft_memset(void *s, int c, size_t n);

/**
 * @brief Copies memory from one area to another.
 *
 * Copies `n` bytes from the memory area `src` to the memory area `dest`.
 * The memory areas must not overlap.
 *
 * @param dest The destination memory area.
 * @param src The source memory area.
 * @param n The number of bytes to copy.
 * @return A pointer to the destination memory area `dest`.
 * @warning DEPRECATED use `ft_memmove` instead it manage overlap.
 */
void			*ft_memcpy(void *dest, const void *src, size_t n);

/**
 * @brief Moves memory from one area to another.
 *
 * Copies `n` bytes from the memory area `src` to `dest`, handling overlap
 * between the source and destination.
 *
 * @param dest The destination memory area.
 * @param src The source memory area.
 * @param n The number of bytes to copy.
 * @return A pointer to the destination memory area `dest`.
 */
void			*ft_memmove(void *dest, const void *src, size_t n);

/**
 * @brief Scans a memory area for a specific byte.
 *
 * Searches the first `n` bytes of the memory area pointed to by `s` for the
 * first occurrence of the value `c` (interpreted as an unsigned char).
 *
 * @param s The memory area to search.
 * @param c The value to find.
 * @param n The number of bytes to search.
 * @return A pointer to the matching byte, or `NULL` if the byte is not found.
 */
void			*ft_memchr(const void *s, int c, size_t n);

/**
 * @brief Compares two memory areas.
 *
 * Compares the first `n` bytes of the memory areas `s1` and `s2`.
 *
 * @param s1 The first memory area.
 * @param s2 The second memory area.
 * @param n The number of bytes to compare.
 * @return An integer less than, equal to, or greater than zero if `s1` is
 *         found to be less than, equal to, or greater than `s2`.
 */
int				ft_memcmp(const void *s1, const void *s2, size_t n);

//* ft_utils
/**
 * @brief Fills a memory area with zeros.
 *
 * Sets the first `n` bytes of the memory area pointed to by `s` to zero.
 *
 * @param s The memory area to fill.
 * @param n The number of bytes to set to zero.
 */
void			ft_bzero(void *s, size_t n);

/**
 * @brief Allocates memory and initializes it to zero.
 *
 * Allocates memory for an array of `nmemb` elements of `size` bytes each,
 * and initializes all bytes in the allocated memory to zero.
 * If `nmemb` or `size` is 0, then `ft_calloc()` returns a unique pointer 
 * value  that can later be successfully passed to `free()`.
 * 
 * @param nmemb The number of elements.
 * @param size The size of each element in bytes.
 * @return A pointer to the allocated memory, or `NULL` if allocation fails.
 * @note If  the  multiplication of `nmemb` and `size` would result in 
 * integer overflow, then `ft_calloc()` returns an error.
 */
void			*ft_calloc(size_t nmemb, size_t size);

/**
 * @brief Returns the absolute value of an integer.
 *
 * @param value The integer to compute the absolute value of.
 * @return The absolute value of the integer.
 */
unsigned int	ft_abs(int value);

//* ft_conversion
/**
 * @brief Converts a string to an integer.
 *
 * Parses the string `nptr` and converts it to an integer.
 *
 * @param nptr The string to convert.
 * @return The integer representation of the string.
 * @note Do not manage overflow.
 */
int				ft_atoi(const char *nptr);

/**
 * @brief Converts an integer to its string representation.
 *
 * Allocates and returns a string representing the integer `n` in base 10.
 *
 * @param n The integer to convert.
 * @return A pointer to the newly allocated string, or `NULL` if
 * allocation fails.
 */
char			*ft_itoa(int n);

//* ft_output
/**
 * @brief Writes a character to a file descriptor.
 *
 * @param c The character to write.
 * @param fd The file descriptor to write to.
 */
void			ft_putchar_fd(char c, int fd);

/**
 * @brief Writes a string to a file descriptor.
 *
 * @param s The string to write.
 * @param fd The file descriptor to write to.
 */
void			ft_putstr_fd(char *s, int fd);

/**
 * @brief Writes a string followed by a newline to a file descriptor.
 *
 * @param s The string to write.
 * @param fd The file descriptor to write to.
 */
void			ft_putendl_fd(char *s, int fd);

/**
 * @brief Writes an integer as a string to a file descriptor.
 *
 * Converts the integer `n` to its string representation and writes it to
 * the file descriptor `fd`.
 *
 * @param n The integer to write.
 * @param fd The file descriptor to write to.
 */
void			ft_putnbr_fd(int n, int fd);

//* BONUS

/**
 * @struct s_list
 * @brief Represents a node in a linked list.
 */
typedef struct s_list
{
	void			*content; /**< Pointer to the content of the node. */
	struct s_list	*next; /**< Pointer to the next node. */
}	t_list;

/**
 * @typedef t_lst_f
 * @brief Function pointer type for list element operations.
 */
typedef void	(*t_lst_f) (void *);

/**
 * @brief Creates a new node for a linked list.
 *
 * Allocates and returns a new node containing the given `content`.
 *
 * @param content The content to store in the new node.
 * @return A pointer to the new node, or `NULL` if allocation fails.
 */
t_list			*ft_lstnew(void *content);

/**
 * @brief Counts the number of elements in a linked list.
 *
 * @param lst The first node of the linked list.
 * @return The number of nodes in the list.
 */
int				ft_lstsize(t_list *lst);

/**
 * @brief Finds the last node in a linked list.
 *
 * @param lst The first node of the linked list.
 * @return A pointer to the last node, or `NULL` if the list is empty.
 */
t_list			*ft_lstlast(t_list *lst);

/**
 * @brief Finds the node at an offset from the last node in a linked list.
 *
 * @param lst The first node of the linked list.
 * @param offset The offset from the last node.
 * @return A pointer to the node at the specified offset, or `NULL` if
 * the offset is invalid.
 */
t_list			*ft_lstoflast(t_list *lst, size_t offset);

/**
 * @brief Adds a node at the beginning of a linked list.
 *
 * Inserts the node `new` at the start of the linked list `lst`.
 *
 * @param lst A pointer to the pointer to the first node of the list.
 * @param new The new node to add.
 */
void			ft_lstadd_front(t_list **lst, t_list *new);

/**
 * @brief Adds a node at the end of a linked list.
 *
 * Appends the node `new` to the end of the linked list `lst`.
 *
 * @param lst A pointer to the pointer to the first node of the list.
 * @param new The new node to add.
 */
void			ft_lstadd_back(t_list **lst, t_list *new);

/**
 * @brief Deletes a single node from a linked list.
 *
 * Deletes the node `lst` using the function `del` to free its content.
 *
 * @param lst The node to delete.
 * @param del The function to free the node's content.
 */
void			ft_lstdelone(t_list *lst, t_lst_f del);

/**
 * @brief Deletes all nodes in a linked list.
 *
 * Frees all nodes in the linked list `lst` using the function `del` and
 * sets the list pointer to `NULL`.
 *
 * @param lst A pointer to the pointer to the first node of the list.
 * @param del The function to free the nodes' content.
 */
void			ft_lstclear(t_list **lst, t_lst_f del);

/**
 * @brief Iterates through a linked list and applies a function to each node.
 *
 * @param lst The first node of the list.
 * @param f The function to apply to each node's content.
 */
void			ft_lstiter(t_list *lst, void (*f)(void *));

/**
 * @brief Iterates through a linked list and applies a function to
 * each node with an index.
 *
 * @param lst The first node of the list.
 * @param f The function to apply to each node's content, with its index.
 */
void			ft_lstiteri(t_list *lst, void (*f)(void *, size_t));

/**
 * @brief Maps a function to each node of a linked list, creating a new list.
 *
 * Applies the function `f` to each node's content to create a new list. If
 * an allocation fails, the function deletes the new list using `del`.
 *
 * @param lst The first node of the list.
 * @param f The function to apply to each node's content.
 * @param del The function to free the nodes' content in case of failure.
 * @return A pointer to the new list, or `NULL` if allocation fails.
 */
t_list			*ft_lstmap(t_list *lst, void *(*f)(void *), t_lst_f del);

#endif
