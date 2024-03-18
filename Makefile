#########################
#      WRITE FUNCT      #
#########################

grey	= /bin/echo -e "\x1b[30m$1\x1b[0m"
red		= /bin/echo -e "\x1b[31m$1\x1b[0m"
green	= /bin/echo -e "\x1b[32m$1\x1b[0m"
yellow	= /bin/echo -e "\x1b[33m$1\x1b[0m"
blue 	= /bin/echo -e "\x1b[34m$1\x1b[0m"
purple	= /bin/echo -e "\x1b[35m$1\x1b[0m"
cyan	= /bin/echo -e "\x1b[36m$1\x1b[0m"
white	= /bin/echo -e "\x1b[37m$1\x1b[0m"

#########################
#        RECIPES        #
#########################

NAME		=	nm
SRC_C		=	main.c
INC			=	nm.h
LIBS		=

CC 		= cc
CFLAG	=	-g3 -Wall -Werror -Wextra
HFLAG	=	-MMD

#########################
#      DEFINE SRCS      #
#########################

INC_PATH	=	includes/
SRC_PATH	=	srcs/

OBJ_PATH	=	.obj/
DEP_PATH	=	.dep/

OBJ_C		=	$(SRC_C:.c=.o)
OBJS_C		=	$(addprefix $(OBJ_PATH), $(OBJ_C))

OBJ_H		=	$(INC:.h=.d)
OBJS_H		=	$(addprefix $(DEP_PATH), $(OBJ_H))

RM		=	rm -f
RMDIR	=	rm -rf
MKDIR	=	mkdir -p
ECHO 	=	/bin/echo -n

#########################
#        INCLUDES       #
#########################

$(NAME): $(OBJS_C) $(OBJS_H)
	@($(CC) $(CFLAG) $(LIBS) $(OBJS_C) -o $(NAME)\
		&& $(call purple, "./$@ ✅")\
		|| ($(call red, "./$@ ❌")))

#########################
#       BUILD RULES     #
#########################

$(OBJ_PATH)%.o: $(SRC_PATH)%.c
	@$(MKDIR) $(OBJ_PATH)
	@$(CC) $(CFLAG) -c $< -o $@ -I $(INC_PATH)\
		&& $(call green,"$< '->' $@ ✅")\
		|| ($(call red, "$< '->' $@ ❌"))

$(DEP_PATH)%.d:	$(INC_PATH)%.h
	@$(MKDIR) $(DEP_PATH)
	@$(CC) $(CFLAG) $(HFLAG) $< -o $@\
		&& $(call green,"$< '->' $@ ✅")\
		|| ($(call red, "$< '->' $@ ❌"))

#########################
#       CLEAN RULES     #
#########################

clean:
	@if [ -d "$(OBJ_PATH)" ];	then $(RMDIR) $(OBJ_PATH) 	&& $(call blue, "$(OBJ_PATH) 🚮"); fi
	@if [ -d "$(DEP_PATH)" ];	then $(RMDIR) $(DEP_PATH)	&& $(call blue, "$(DEP_PATH) 🚮"); fi

#########################
#      FCLEAN RULES     #
#########################

fclean: clean
	@if [ -e "$(NAME)" ]; 		then $(RM) $(NAME)			&& $(call blue, "./$(NAME) 🚮"); fi

#######################
#       RE RULES      #
#######################

re: fclean
	@make -s

#######################
#      ALL RULES      #
#######################

all: $(NAME) $(NAME_TEST)

.PHONY: all clean fclean re test