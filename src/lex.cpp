////////////////////////////////////////////////////////////////////////////////

// #include <iostream>
#include <Lexer.h>
#include <Context.h>
#include "ios_error.h"

Context context;

int main (int argc, char** argv)
{
  for (auto i = 1; i < argc; i++)
  {
    // std::cout << "argument '" << argv[i] << "'\n";
    printf("argument '%s'\n", argv[i]); 

    Lexer l (argv[i]);
    std::string token;
    Lexer::Type type;
    while (l.token (token, type))
      printf("  token '%s' %s\n", token.c_str(), Lexer::typeToString (type).c_str());
      // std::cout << "  token '" << token << "' " << Lexer::typeToString (type) << "\n";
  }
}

////////////////////////////////////////////////////////////////////////////////
