Vim�UnDo� zv|�t os�Ѯ*��vLf��Zs�H	��\\   5                 /       /   /   /    _�+p    _�                             ����                                                                                                                                                                                                                                                                                                                                                             _�*J    �                   5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             _�*M     �                 
#include "�                  �               5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             _�*U    �                 #include "myflint_ZZ_mat.hpp5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             _�*W     �                  �               5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             _�*^     �                 �             �                  5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             _�*l    �                 fmpz_5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             _�*�     �             5�_�      	                      ����                                                                                                                                                                                                                                                                                                                                                             _�*�     �      #       �             5�_�      
           	           ����                                                                                                                                                                                                                                                                                                                                      "          V       _�*�    �   !   #            ~ZZ_mat();�       "          -  ZZ_mat &operator=(ZZ_mat &&other) noexcept;�      !          )  ZZ_mat& operator=(const ZZ_mat &other);�                &  bool dim_match(const ZZ_mat &other);�                "  ZZ_mat(ZZ_mat &&other) noexcept;�                  ZZ_mat(const ZZ_mat& other);�                !  ZZ_mat(const fmpz_mat_t other);�                4    ZZ_mat(const vector<vector<T>>& mat_as_vectors);�                  ZZ_mat();�                  ZZ_mat(int nrows, int ncols);�                -  ZZ_vec_ptr operator[](const int row) const;�                >  ZZ_mat& operator()(const int& row, const int& col, ZZ&& in);�                C  ZZ_mat& operator()(const int& row, const int& col, const ZZ& in);5�_�   	              
          ����                                                                                                                                                                                                                                                                                                                                      "          V       _�*�     �         #    5�_�   
                 	        ����                                                                                                                                                                                                                                                                                                                            	          
          V       _�*�    �   	             \  explicit operator const fmpz_mat_struct*() const { return (const fmpz_mat_struct*) data; }�      
          J  explicit operator fmpz_mat_struct*() { return (fmpz_mat_struct*) data; }5�_�                           ����                                                                                                                                                                                                                                                                                                                            	          
          V       _�*�    �                9  fmpz* operator()(const int& row, const int& col) const;5�_�                            ����                                                                                                                                                                                                                                                                                                                                                V       _�*�     �                C  RR_mat& operator()(const int& row, const int& col, const RR& in);   >  RR_mat& operator()(const int& row, const int& col, RR&& in);5�_�                           ����                                                                                                                                                                                                                                                                                                                                                V       _�*�     �         !    5�_�                            ����                                                                                                                                                                                                                                                                                                                                                V       _�*�     �         "    �         "    5�_�                            ����                                                                                                                                                                                                                                                                                                                                                V       _�*�     �   	             *  ZZ_ptr operator[](const int col) const {�      	          +  ZZ_vec_ptr(fmpz* in_row) : row(in_row) {}�                struct ZZ_vec_ptr {5�_�                           ����                                                                                                                                                                                                                                                                                                                                                V       _�*�    �         +        fmpz* row;5�_�                           ����                                                                                                                                                                                                                                                                                                                                                V       _�*�   
 �      	   +      +  RR_vec_ptr(fmpz* in_row) : row(in_row) {}5�_�                           ����                                                                                                                                                                                                                                                                                                                                                V       _�*�     �         +    5�_�                            ����                                                                                                                                                                                                                                                                                                                                                V       _�*�     �                 5�_�                            ����                                                                                                                                                                                                                                                                                                                                                V       _�*�     �         +    5�_�                            ����                                                                                                                                                                                                                                                                                                                                                V       _�*�     �         ,    �         ,    5�_�                            ����                                                                                                                                                                                                                                                                                                                                                V       _�+     �         .    �         .    5�_�                    
       ����                                                                                                                                                                                                                                                                                                                                                V       _�+    �   
      3        �   
      2    5�_�                            ����                                                                                                                                                                                                                                                                                                                                                  V        _�+    �   	               ZZ_ptr(fmpz* in) : ptr(in) {}�                struct ZZ_ptr{5�_�                           ����                                                                                                                                                                                                                                                                                                                                                  V        _�+    �         3        fmpz* ptr;5�_�                           ����                                                                                                                                                                                                                                                                                                                                                  V        _�+     �         3      +  explicit operator fmpz*() { return ptr; }5�_�                           ����                                                                                                                                                                                                                                                                                                                                                  V        _�+     �      	   3      7  explicit operator const fmpz*() const { return ptr; }5�_�                    
   	    ����                                                                                                                                                                                                                                                                                                                                                  V        _�+    �   	      3        RR_ptr(fmpz* in) : ptr(in) {}5�_�                            ����                                                                                                                                                                                                                                                                                                                                                  V        _�+6     �         4        �         3    5�_�                     3       ����                                                                                                                                                                                                                                                                                                                                                  V        _�+<    �   3   5   5        �   3   5   4    5�_�      !               4       ����                                                                                                                                                                                                                                                                                                                                                  V        _�+>     �   3   4            #endif5�_�       "           !   /        ����                                                                                                                                                                                                                                                                                                                                                  V        _�+@     �   /   1   4    �   /   0   4    5�_�   !   #           "   -       ����                                                                                                                                                                                                                                                                                                                                                  V        _�+B     �   ,   -          "  RR_mat(RR_mat &&other) noexcept;5�_�   "   $           #   0        ����                                                                                                                                                                                                                                                                                                                                                  V        _�+C     �   0   2   4    �   0   1   4    5�_�   #   %           $   ,       ����                                                                                                                                                                                                                                                                                                                                                  V        _�+G     �   +   ,            RR_mat(const RR_mat& other);5�_�   $   '           %   /        ����                                                                                                                                                                                                                                                                                                                                                  V        _�+H     �   /   1   4    �   /   0   4    5�_�   %   (   &       '   0       ����                                                                                                                                                                                                                                                                                                                                                  V        _�+P     �   /   1   5    �   0   1   5    5�_�   '   )           (   0       ����                                                                                                                                                                                                                                                                                                                            0          0          v       _�+T    �   /   1   6        RR_mat(const RR_mat& other);5�_�   (   *           )   &       ����                                                                                                                                                                                                                                                                                                                            0          0          v       _�+a     �   %   &            RR_mat();5�_�   )   +           *   .        ����                                                                                                                                                                                                                                                                                                                            /          /          v       _�+c     �   .   0   5    �   .   /   5    5�_�   *   ,           +   %       ����                                                                                                                                                                                                                                                                                                                            0          0          v       _�+e     �   $   %            RR_mat(int nrows, int ncols);5�_�   +   -           ,   .        ����                                                                                                                                                                                                                                                                                                                            /          /          v       _�+g     �   .   0   5    �   .   /   5    5�_�   ,   .           -   $        ����                                                                                                                                                                                                                                                                                                                            0          0          v       _�+i    �   #   $           5�_�   -   /           .           ����                                                                                                                                                                                                                                                                                                                            /          /          v       _�+n     �                  #if 05�_�   .               /   #        ����                                                                                                                                                                                                                                                                                                                            .          .          v       _�+o    �   #   %   4    �   #   $   4    5�_�   %           '   &   &       ����                                                                                                                                                                                                                                                                                                                                                  V        _�+J     �   %   '        5��