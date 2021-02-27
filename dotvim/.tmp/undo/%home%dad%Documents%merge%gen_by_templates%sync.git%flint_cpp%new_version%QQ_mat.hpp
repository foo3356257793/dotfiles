Vim�UnDo� ��^��p�2ju��S����@ܜ�W(�y���	"   :                                   `4y    _�                            ����                                                                                                                                                                                                                                                                                                                                                             `4o     �   4   6           #include "ZZ_mat/ZZ_mat_fun.hpp"�   0   2            #undef _ZZ_mat�   /   1          %  #include "ZZ_mat/ZZ_mat_struct.hpp"�   .   0            #define _ZZ_mat ZZ_mat_ptr�   ,   .            ~ZZ_mat_ptr() {}�   *   ,          ;  ZZ_mat_ptr &operator=(ZZ_mat_ptr &&in) noexcept = delete;�   )   +          7  ZZ_mat_ptr &operator=(ZZ_mat &&in) noexcept = delete;�   (   *          0  ZZ_mat_ptr(ZZ_mat_ptr &&in) noexcept = delete;�   '   )          ,  ZZ_mat_ptr(ZZ_mat &&in) noexcept = delete;�   &   (          ,  ZZ_mat_ptr(const ZZ_mat_ptr &in) = delete;�   %   '          (  ZZ_mat_ptr(const ZZ_mat &in) = delete;�   #   %          /  ZZ_mat_ptr(fmpz_mat_struct *in) : data(in) {}�   "   $            ZZ_mat_ptr() = delete;�                 struct ZZ_mat_ptr {�                  ~ZZ_mat();�                *  ZZ_mat &operator=(ZZ_mat &&in) noexcept;�                  ZZ_mat(ZZ_mat &&in) noexcept;�                  ZZ_mat();�                  ZZ_mat(int rows, int cols);�                #  #include "ZZ_mat/ZZ_mat_only.hpp"�                  #undef _ZZ_mat�                %  #include "ZZ_mat/ZZ_mat_struct.hpp"�                  #define _ZZ_mat ZZ_mat�   
             struct ZZ_mat {�      
          struct ZZ_mat_ptr;�      	          struct ZZ_mat;�                #include "ZZ_vec.hpp"5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             `4o    �         6      #include <flint/fmpz_mat.h>5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             `4oR     �         6      #include "QQ_vec.hpp"5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             `4oS     �         7       �         6    5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             `4oY     �         7    �         7    5�_�      	                 
    ����                                                                                                                                                                                                                                                                                                                               
                 v       `4o\    �         8      #include "ZZ_mat.hpp"5�_�      
           	          ����                                                                                                                                                                                                                                                                                                                               
                 v       `4o�    �         8        fmpz_mat_t data;5�_�   	              
   #       ����                                                                                                                                                                                                                                                                                                                               
                 v       `4o�    �   "   $   8        fmpz_mat_struct *data;5�_�   
                         ����                                                                                                                                                                                                                                                                                                                                                             `4s�     �                //#include "QQ_vec.hpp"5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             `4s�     �         7    �         7    5�_�                            ����                                                                                                                                                                                                                                                                                                                                                 v       `4s�    �         8      //#include "QQ_vec.hpp"5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             `4t5     �         8    5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             `4t6     �         9      #include "QQ.hpp"5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             `4t7   	 �         :       �         9    5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             `4tJ     �         ;        �         :    5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             `4tK    �         <        �         ;    5�_�                    *       ����                                                                                                                                                                                                                                                                                                                                                             `4tY    �   )   +   <      /  QQ_mat_ptr(fmpz_mat_struct *in) : data(in) {}5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             `4t�     �         <    5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             `4t�     �         >       �         =    5�_�                    >        ����                                                                                                                                                                                                                                                                                                                                                             `4t�    �   >               �   >            5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             `4t�     �                #if 0    5�_�                    $        ����                                                                                                                                                                                                                                                                                                                                                             `4t�    �   $   '   =    �   $   %   =    5�_�                    %        ����                                                                                                                                                                                                                                                                                                                                                             `4t�     �   $   %          #if 05�_�                    >        ����                                                                                                                                                                                                                                                                                                                                                             `4t�     �   =   >          #endif5�_�                    =        ����                                                                                                                                                                                                                                                                                                                                                             `4t�    �   <   =           5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             `4y     �                  #if 05�_�                            ����                                                                                                                                                                                                                                                                                                                                                             `4y    �                  #endif5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             `4y
     �              5�_�                             ����                                                                                                                                                                                                                                                                                                                                                             `4o     �                #include "QQ_vec.hpp"�      	          struct QQ_mat;�      
          struct QQ_mat_ptr;�   
             struct QQ_mat {�                $  #define _QQ_mat QQ_mat�                1  #include "QQ_mat/QQ_mat_struct.hpp"�                  #undef _QQ_mat�                /  #include "QQ_mat/QQ_mat_only.hpp"�                #  QQ_mat(int rows, int cols);�                  QQ_mat();�                +  QQ_mat(QQ_mat &&in) noexcept;�                6  QQ_mat &operator=(QQ_mat &&in) noexcept;�                  ~QQ_mat();�                 struct QQ_mat_ptr {�   "   $            QQ_mat_ptr() = delete;�   #   %          5  QQ_mat_ptr(fmpz_mat_struct *in) : data(in) {}5��