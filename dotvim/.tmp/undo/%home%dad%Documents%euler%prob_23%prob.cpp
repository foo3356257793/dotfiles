Vim�UnDo� �sSo��˛���� �%tK}�LJM��ud   ]                 N       N   N   N    _7�F   / _�                             ����                                                                                                                                                                                                                                                                                                                                                             _7��     �       
       5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             _7��     �             �                �         
    5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             _7��    �                 �             5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             _7��     �      
              bound = 28123�      	          3    # how to find these: can bound down to <= 28123�      
       �             5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             _7��    �      	         1  # how to find these: can bound down to <= 281235�_�                    	       ����                                                                                                                                                                                                                                                                                                                                                             _7��     �      
           bound = 281235�_�                    	       ����                                                                                                                                                                                                                                                                                                                                                             _7��    �      
           const int bound = 281235�_�      	              	       ����                                                                                                                                                                                                                                                                                                                                                             _7��     �   	          5�_�      
           	   
        ����                                                                                                                                                                                                                                                                                                                                                             _7��     �   
             %    sum_of_divisors = [1] * (bound+1)�   
          �   
          5�_�   	              
          ����                                                                                                                                                                                                                                                                                                                                                             _7��     �   
            #  sum_of_divisors = [1] * (bound+1)5�_�   
                        ����                                                                                                                                                                                                                                                                                                                                                             _7��     �   
            '  int sum_of_divisors = [1] * (bound+1)5�_�                      !    ����                                                                                                                                                                                                                                                                                                                                                             _7��    �   
            0  int sum_of_divisors[bound+1] = [1] * (bound+1)5�_�                       "    ����                                                                                                                                                                                                                                                                                                                                                             _7�    �   
            %  int sum_of_divisors[bound+1] = {0};5�_�                       "    ����                                                                                                                                                                                                                                                                                                                                                             _7�   	 �                   �             �                 �             5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             _7�1     �             5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             _7�1     �             �             5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             _7�5     �         (    5�_�                            ����                                                                                                                                                                                                                                                                                                                                                          _7�:     �         )      using std::string;�         )      using std::fstream;5�_�                            ����                                                                                                                                                                                                                                                                                                                                                          _7�=   
 �         )      using std::remove;   using std::sort;�         )      using std::ios;5�_�                            ����                                                                                                                                                                                                                                                                                                                                                          _7�@     �                #include <fstream>5�_�                            ����                                                                                                                                                                                                                                                                                                                                                          _7�B    �         (      #include <algorithm>5�_�                           ����                                                                                                                                                                                                                                                                                                                                                          _7�T    �         (      %  int sum_of_divisors[bound+1] = {1};5�_�                           ����                                                                                                                                                                                                                                                                                                                                                          _7�U    �         )        �         (    5�_�                           ����                                                                                                                                                                                                                                                                                                                            !                    V       _7�p    �                  for(int i=0; i<5; i++)     {   '    cout << sum_of_divisors[i] << endl;     }5�_�                            ����                                                                                                                                                                                                                                                                                                                                                V       _7�s     �         &    5�_�                           ����                                                                                                                                                                                                                                                                                                                                                V       _7�u     �         (        �         '    5�_�                           ����                                                                                                                                                                                                                                                                                                                                                  V       _7�y     �         )        �         (    5�_�                           ����                                                                                                                                                                                                                                                                                                                            !          !          V       _7�}    �         )        for(int i=0; i<bound+1; i++)5�_�                           ����                                                                                                                                                                                                                                                                                                                            !          !          V       _7��     �   !   #   .          �   !   #   -    �      #   *        �          )    5�_�                     "       ����                                                                                                                                                                                                                                                                                                                            &          &          V       _7��     �   !   #   .          multiple 5�_�      !               "       ����                                                                                                                                                                                                                                                                                                                            &          &          V       _7��    �   !   #   .          int multiple 5�_�       "           !   "       ����                                                                                                                                                                                                                                                                                                                            &          &          V       _7��    �   %   '   3            �   %   '   2    �   "   '   /          �   "   $   .    5�_�   !   #           "   &   $    ����                                                                                                                                                                                                                                                                                                                            +          +          V       _7��     �   &   (   4            �   &   (   3    5�_�   "   $           #   '       ����                                                                                                                                                                                                                                                                                                                            ,          ,          V       _7��    �   &   (   4            num_abundant5�_�   #   %           $       
    ����                                                                                                                                                                                                                                                                                                                            ,          ,          V       _7��     �      !   4      $  for(int i=2; i<((bound+1)/2); i++)5�_�   $   &           %           ����                                                                                                                                                                                                                                                                                                                            ,          ,          V       _7��     �      !   4      *  for(int divisor=2; i<((bound+1)/2); i++)5�_�   %   '           &       ,    ����                                                                                                                                                                                                                                                                                                                            ,          ,          V       _7��     �      !   4      0  for(int divisor=2; divisor<((bound+1)/2); i++)5�_�   &   (           '   "       ����                                                                                                                                                                                                                                                                                                                            ,          ,          V       _7��     �   !   #   4          int multiple = 2*i;5�_�   '   )           (   &   #    ����                                                                                                                                                                                                                                                                                                                            ,          ,          V       _7��     �   %   '   4      %      sum_of_divisors[multiple] += i;5�_�   (   *           )   '       ����                                                                                                                                                                                                                                                                                                                            ,          ,          V       _7��    �   &   (   4            multiple += i;5�_�   )   +           *   )       ����                                                                                                                                                                                                                                                                                                                            ,          ,          V       _7��    �   )   ,   5        �   )   +   4    5�_�   *   ,           +   +   #    ����                                                                                                                                                                                                                                                                                                                            .          .          V       _7��     �   .   0   ;          �   .   0   :    �   +   0   7        �   +   -   6    5�_�   +   -           ,   /       ����                                                                                                                                                                                                                                                                                                                            3          3          V       _7��    �   0   2   >            �   0   2   =    �   .   2   ;          if(sum_of_divisors[i]5�_�   ,   .           -   3       ����                                                                                                                                                                                                                                                                                                                            6          6          V       _7��    �   3   6   ?        �   3   5   >    5�_�   -   /           .   5   /    ����                                                                                                                                                                                                                                                                                                                            8          8          V       _7�J     �   8   :   E          �   8   :   D    �   5   :   A        �   5   7   @    5�_�   .   0           /   9       ����                                                                                                                                                                                                                                                                                                                            =          =          V       _7�_     �   8   :   E          for(int j=0; j<5�_�   /   1           0   9       ����                                                                                                                                                                                                                                                                                                                            =          =          V       _7�`    �   :   <   H            �   :   <   G    �   8   <   E          for(int j=i; j<5�_�   0   2           1   ;   >    ����                                                                                                                                                                                                                                                                                                                            @          @          V       _7�p     �   ;   >   I            �   ;   =   H    5�_�   1   3           2   =       ����                                                                                                                                                                                                                                                                                                                            B          B          V       _7�v     �   <   >   J            if sum_abundant > bound5�_�   2   4           3   =       ����                                                                                                                                                                                                                                                                                                                            B          B          V       _7�w     �   <   ?   J            if(sum_abundant > bound5�_�   3   5           4   >       ����                                                                                                                                                                                                                                                                                                                            C          C          V       _7�y     �   =   ?   L              break    �   >   @   L      
          �   >   @   K    5�_�   4   6           5   >       ����                                                                                                                                                                                                                                                                                                                            C          C          V       _7�|     �   >   A   L            �   >   @   K    5�_�   5   7           6   =       ����                                                                                                                                                                                                                                                                                                                            E          E          V       _7�     �   =   @   N              �   =   ?   M    5�_�   6   8           7   >       ����                                                                                                                                                                                                                                                                                                                            G          G          V       _7��     �   >   @   P    �   =   @   O            {5�_�   7   9           8   B       ����                                                                                                                                                                                                                                                                                                                            I          I          V       _7��     �   A   B                  break;5�_�   8   :           9   ?        ����                                                                                                                                                                                                                                                                                                                            H          H          V       _7��     �   ?   A   P    �   ?   @   P    5�_�   9   ;           :   ?        ����                                                                                                                                                                                                                                                                                                                            I          I          V       _7��     �   >   ?           5�_�   :   <           ;   B        ����                                                                                                                                                                                                                                                                                                                            H          H          V       _7��     �   A   B           5�_�   ;   =           <   B       ����                                                                                                                                                                                                                                                                                                                            G          G          V       _7��     �   A   C   O            i5�_�   <   >           =   5       ����                                                                                                                                                                                                                                                                                                                            G          G          V       _7��    �   5   8   P        �   5   7   O    5�_�   =   ?           >   7       ����                                                                                                                                                                                                                                                                                                                            I          I          V       _7��    �   9   ;   U          �   9   ;   T    �   7   ;   R        �   7   9   Q    5�_�   >   @           ?   7       ����                                                                                                                                                                                                                                                                                                                            M          M          V       _7��     �   6   8   U        int is_sum[bound+1];5�_�   ?   A           @   :       ����                                                                                                                                                                                                                                                                                                                            M          M          V       _7��   ! �   9   ;   U          is_sum[i] = 0;5�_�   @   B           A   H       ����                                                                                                                                                                                                                                                                                                                            M          M          V       _7��   " �   G   I   U      	      if(5�_�   A   C           B   J       ����                                                                                                                                                                                                                                                                                                                            M          M          V       _7��   # �   J   M   V        �   J   L   U    5�_�   B   D           C   L       ����                                                                                                                                                                                                                                                                                                                            O          O          V       _7��     �   L   O   X        �   L   N   W    5�_�   C   E           D   N       ����                                                                                                                                                                                                                                                                                                                            Q          Q          V       _7��     �   O   Q   \          �   O   Q   [    �   M   Q   Y        for sum_abundant5�_�   D   F           E   P       ����                                                                                                                                                                                                                                                                                                                            T          T          V       _7��     �   O   Q   \          if(is_sum[i])5�_�   E   G           F   P       ����                                                                                                                                                                                                                                                                                                                            T          T          V       _7��   $ �   O   Q   \          if(is_sum[i])5�_�   F   H           G   P   
    ����                                                                                                                                                                                                                                                                                                                            T          T          V       _7��     �   P   R   \    5�_�   G   I           H   P       ����                                                                                                                                                                                                                                                                                                                            U          U          V       _7��   % �   Q   S   `            �   Q   S   _    �   O   S   ]          if(not is_sum[i])5�_�   H   J           I   U       ����                                                                                                                                                                                                                                                                                                                            X          X          V       _7�   ' �   U   X   a        �   U   W   `    5�_�   I   K           J   =        ����                                                                                                                                                                                                                                                                                                                            Z          Z          V       _7�   ) �   <   >   b      !  for(int i=0; i<number_abundant)5�_�   J   L           K   A       ����                                                                                                                                                                                                                                                                                                                            Z          Z          V       _7�   + �   @   B   b      ?      sum_abundant = abundant_numbers[i] + abundant_numbers[j];5�_�   K   M           L   L       ����                                                                                                                                                                                                                                                                                                                            Z          Z          V       _7�   - �   K   M   b        answer = 0;5�_�   L   N           M           ����                                                                                                                                                                                                                                                                                                                                                V       _7�D     �                //using std::fstream;   //using std::string;5�_�   M               N           ����                                                                                                                                                                                                                                                                                                                                                  V        _7�E   / �                //using std::ios;   //using std::remove;   //using std::sort;5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             _7��    �   
              vector<int>5��