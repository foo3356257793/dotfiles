Vim�UnDo� ^�z��0������LF�nc�%�W� W:�   �                 >       >   >   >    _���   , _�                        #    ����                                                                                                                                                                                                                                                                                                                                                             _�9�    �         �      AZZ::ZZ(const ZZ &other) : ZZ(other.number) {} // copy constructor5�_�                       
    ����                                                                                                                                                                                                                                                                                                                                                             _�9�    �          �      #include "myflint_ZZ.hpp"5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             _�:$    �                 5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             _�:'    �                 5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             _�:/    �                 5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             _�:5    �   
              5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             _�:�     �         �      NZZ::ZZ(const ZZ_ptr &ptr) { fmpz_init_set((fmpz*) *this, (const fmpz*) ptr); }5�_�                          ����                                                                                                                                                                                                                                                                                                                                                 v       _�:�     �      	   �    �         �    5�_�                            ����                                                                                                                                                                                                                                                                                                                                                 v       _�:�     �      	   �      P//ZZ::ZZ(const ZZ_ptr &ptr) { fmpz_init_set((fmpz*) *this, (const fmpz*) ptr); }5�_�                           ����                                                                                                                                                                                                                                                                                                                                                 v       _�:�     �      	   �      NZZ::ZZ(const ZZ_ptr &ptr) { fmpz_init_set((fmpz*) *this, (const fmpz*) ptr); }5�_�                           ����                                                                                                                                                                                                                                                                                                                                                 v       _�:�    �      	   �      ZZ::ZZ(const ZZ_ptr &ptr) {}5�_�                           ����                                                                                                                                                                                                                                                                                                                                                 v       _�;/     �      	   �      +ZZ::ZZ(const ZZ_ptr &ptr) : ZZ(ptr.data) {}5�_�                       0    ����                                                                                                                                                                                                                                                                                                                                                 v       _�;4    �      	   �      9ZZ::ZZ(const ZZ_ptr &ptr) : ZZ((const fmpz*) ptr.data) {}5�_�                       *    ����                                                                                                                                                                                                                                                                                                                                                 v       _�;A    �      	   �      4ZZ::ZZ(const ZZ_ptr &ptr) : ZZ((const fmpz*) ptr) {}5�_�                            ����                                                                                                                                                                                                                                                                                                                                                 v       _�;H     �                5ZZ::ZZ(const ZZ_ptr &ptr) : ZZ((const fmpz_t) ptr) {}5�_�                            ����                                                                                                                                                                                                                                                                                                                                                 v       _�;I    �         �      P//ZZ::ZZ(const ZZ_ptr &ptr) { fmpz_init_set((fmpz*) *this, (const fmpz*) ptr); }5�_�                            ����                                                                                                                                                                                                                                                                                                                                                 v       _�;�     �                PZZ::ZZ(const int64_t &in_number) { fmpz_init_set_si((fmpz*) *this, in_number); }5�_�                    
        ����                                                                                                                                                                                                                                                                                                                                                 v       _�;�     �   
      �    5�_�                    	        ����                                                                                                                                                                                                                                                                                                                                                 v       _�;�     �   	      �    5�_�                    	        ����                                                                                                                                                                                                                                                                                                                                                 v       _�;�     �   	      �    5�_�                    
        ����                                                                                                                                                                                                                                                                                                                                                 v       _�;�     �   
      �    �   
      �    5�_�                            ����                                                                                                                                                                                                                                                                                                                                                 v       _�;�     �                 5�_�                            ����                                                                                                                                                                                                                                                                                                                                                 v       _�;�     �                 5�_�                             ����                                                                                                                                                                                                                                                                                                                                                 v       _�;�     �         �    �         �    5�_�      !                      ����                                                                                                                                                                                                                                                                                                                                                 v       _�;�    �         �      PZZ::ZZ(const int64_t &in_number) { fmpz_init_set_si((fmpz*) *this, in_number); }5�_�       "           !           ����                                                                                                                                                                                                                                                                                                                                                 v       _�<>     �         �      OZZ::ZZ(const double &in_number) { fmpz_init_set_si((fmpz*) *this, in_number); }5�_�   !   #           "      .    ����                                                                                                                                                                                                                                                                                                                               /          0       v   0    _�<C    �         �      VZZ::ZZ(const double &in_number) : ZZ() { fmpz_init_set_si((fmpz*) *this, in_number); }5�_�   "   $           #   
        ����                                                                                                                                                                                                                                                                                                                               /          0       v   0    _�<�    �   	   
           5�_�   #   %           $   
        ����                                                                                                                                                                                                                                                                                                                               /          0       v   0    _�<�     �   	      �    �   
      �    5�_�   $   &           %   
       ����                                                                                                                                                                                                                                                                                                                               /          0       v   0    _�<�    �   	      �      PZZ::ZZ(const int64_t &in_number) { fmpz_init_set_si((fmpz*) *this, in_number); }5�_�   %   '           &   
   2    ����                                                                                                                                                                                                                                                                                                                               /          0       v   0    _�<�    �   	      �      QZZ::ZZ(const uint64_t &in_number) { fmpz_init_set_si((fmpz*) *this, in_number); }5�_�   &   (           '           ����                                                                                                                                                                                                                                                                                                                                                 V       _�<�     �         �    5�_�   '   )           (           ����                                                                                                                                                                                                                                                                                                                                                 V       _�<�     �         �    �         �    5�_�   (   *           )           ����                                                                                                                                                                                                                                                                                                                                                 V       _�<�     �         �    �         �    5�_�   )   +           *           ����                                                                                                                                                                                                                                                                                                                                                 V       _�<�     �         �    �         �    5�_�   *   ,           +           ����                                                                                                                                                                                                                                                                                                                                                 V       _�<�     �         �    �         �    5�_�   +   -           ,          ����                                                                                                                                                                                                                                                                                                                                                 V       _�=	     �         �      7ZZ &ZZ::operator=(const ZZ &other) { // copy assignment5�_�   ,   .           -           ����                                                                                                                                                                                                                                                                                                                                                 V       _�=     �      !   �      7ZZ &ZZ::operator=(const ZZ &other) { // copy assignment5�_�   -   /           .   $       ����                                                                                                                                                                                                                                                                                                                                                 V       _�=    �   #   %   �      7ZZ &ZZ::operator=(const ZZ &other) { // copy assignment5�_�   .   0           /      
    ����                                                                                                                                                                                                                                                                                                                                                 V       _�=9     �         �      /  fmpz_set((fmpz*) *this, (const fmpz*) other);5�_�   /   1           0          ����                                                                                                                                                                                                                                                                                                                                                 V       _�=?     �         �      3  fmpz_set_str((fmpz*) *this, (const fmpz*) other);5�_�   0   2           1      (    ����                                                                                                                                                                                                                                                                                                                                                 V       _�=F     �         �      ;ZZ &ZZ::operator=(const string &other) { // copy assignment5�_�   1   3           2   !   
    ����                                                                                                                                                                                                                                                                                                                                                 V       _�=K   ! �       "   �      /  fmpz_set((fmpz*) *this, (const fmpz*) other);5�_�   2   4           3   !       ����                                                                                                                                                                                                                                                                                                                                                 V       _�=N     �       "   �      2  fmpz_set_si((fmpz*) *this, (const fmpz*) other);5�_�   3   5           4   !       ����                                                                                                                                                                                                                                                                                                                                                 V       _�=O   " �       "   �      %  fmpz_set_si((fmpz*) *this,  other);5�_�   4   6           5   $   *    ����                                                                                                                                                                                                                                                                                                                                                 V       _�=U     �   #   %   �      =ZZ &ZZ::operator=(const uint64_t &other) { // copy assignment5�_�   5   7           6       )    ����                                                                                                                                                                                                                                                                                                                                                 V       _�=W     �      !   �      <ZZ &ZZ::operator=(const int64_t &other) { // copy assignment5�_�   6   8           7            ����                                                                                                                                                                                                                                                                                                                                (       #          V   (    _�=X     �                 )ZZ &ZZ::operator=(const int64_t &other) {   $  fmpz_set_si((fmpz*) *this, other);     return *this;   }5�_�   7   9           8   #        ����                                                                                                                                                                                                                                                                                                                                (                  V   (    _�=Y     �   #   (   �    �   #   $   �    5�_�   8   :           9   !   
    ����                                                                                                                                                                                                                                                                                                                                (                  V   (    _�=]   # �       "   �      /  fmpz_set((fmpz*) *this, (const fmpz*) other);5�_�   9   ;           :   !       ����                                                                                                                                                                                                                                                                                                                                (                  V   (    _�=`     �       "   �      2  fmpz_set_ui((fmpz*) *this, (const fmpz*) other);5�_�   :   <           ;   !       ����                                                                                                                                                                                                                                                                                                                                (                  V   (    _�=a   & �       "   �      %  fmpz_set_ui((fmpz*) *this,  other);5�_�   ;   =           <          ����                                                                                                                                                                                                                                                                                                                                (                  V   (    _�=x   * �         �      7ZZ &ZZ::operator=(const ZZ &other) { // copy assignment5�_�   <   >           =   #        ����                                                                                                                                                                                                                                                                                                                                                             _���     �   #   %   �    5�_�   =               >           ����                                                                                                                                                                                                                                                                                                                                                             _���   , �      !   �    5�_�      	                    ����                                                                                                                                                                                                                                                                                                                                                             _�:�     �         �    �         �      P//ZZ::ZZ(const ZZ_ptr &ptr) { fmpz_init_set((fmpz*) *this, (const fmpz*) ptr); }5�_�      
           	           ����                                                                                                                                                                                                                                                                                                                                                 v       _�:�     �      	   �      NZZ::ZZ(const ZZ_ptr &ptr) { fmpz_init_set((fmpz*) *this, (const fmpz*) ptr); }5�_�   	              
          ����                                                                                                                                                                                                                                                                                                                                                 v       _�:�     �      	   �      cZZ::ZZ(const ZZ_ptr &ptr) : ZZ((fmpz*) ptr) {} { fmpz_init_set((fmpz*) *this, (const fmpz*) ptr); }5�_�   
                    .    ����                                                                                                                                                                                                                                                                                                                                                 v       _�:�   	 �      	   �      .ZZ::ZZ(const ZZ_ptr &ptr) : ZZ((fmpz*) ptr) {}5�_�                            ����                                                                                                                                                                                                                                                                                                                                                 v       _�:�    �      	   �      4ZZ::ZZ(const ZZ_ptr &ptr) : ZZ((const fmpz*) ptr) {}5�_�                            ����                                                                                                                                                                                                                                                                                                                                                 v       _�:�     �      	        5�_�                     
        ����                                                                                                                                                                                                                                                                                                                                                 v       _�:�    �   
      �    �   
      �      4ZZ::ZZ(const ZZ_ptr &ptr) : ZZ((const fmpz*) ptr) {}5��