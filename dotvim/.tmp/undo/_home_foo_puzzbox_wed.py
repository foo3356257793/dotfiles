Vim�UnDo� w�l��U�B�P-bZEi�����x$   6            *         /       /   /   /    [x�V   K _�                            ����                                                                                                                                                                                                                                                                                                                                                             [x�#    �         =        valid = range(1,4)5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             [x�$    �         =        valid = range(0,4)5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             [x�&    �         =        answer = [2,3]5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             [x�*    �         =        answer = [0,1,0,1]5�_�                       !    ����                                                                                                                                                                                                                                                                                                                                                             [x�.    �         =      @  print "\nToday the password is two numbers between 1 and 4.\n"5�_�                       6    ����                                                                                                                                                                                                                                                                                                                                                             [x�1    �         =      A  print "\nToday the password is four numbers between 1 and 4.\n"5�_�                       <    ����                                                                                                                                                                                                                                                                                                                                                             [x�2    �         =      A  print "\nToday the password is four numbers between 0 and 4.\n"5�_�      	                     ����                                                                                                                                                                                                                                                                                                                                                             [x�7    �         =        guess = [0,0]5�_�      
           	          ����                                                                                                                                                                                                                                                                                                                                                             [x�@    �         =      5        print "\nThat's not a number between 1 and 4"5�_�   	              
      #    ����                                                                                                                                                                                                                                                                                                                               #          $       v   $    [x�G    �         =      &        print "\nThat's not 0 or 1.\n"5�_�   
                        ����                                                                                                                                                                                                                                                                                                                                                v       [x�L    �         =              print "\nTry again.\n"5�_�                           ����                                                                                                                                                                                                                                                                                                                                                v       [x�[    �         =              print "Try again.\n"5�_�                    "       ����                                                                                                                                                                                                                                                                                                                                                v       [x�^    �   !   #   =      3      print "\nThat's not a number between 1 and 4"5�_�                    )   !    ����                                                                                                                                                                                                                                                                                                                                                v       [x�g     �   )   +   =    �   )   *   =    5�_�                    )       ����                                                                                                                                                                                                                                                                                                                                                v       [x�h     �   (   )          3      print "\nThat's not a number between 1 and 4"5�_�                    -       ����                                                                                                                                                                                                                                                                                                                                                v       [x�s     �   -   /   =    �   -   .   =    5�_�                    -       ����                                                                                                                                                                                                                                                                                                                                                v       [x�t   " �   ,   -          1      print "That's not a number between 1 and 4"5�_�                            ����                                                                                                                                                                                                                                                                                                                                                V       [xސ   # �         >          �         =    5�_�                            ����                                                                                                                                                                                                                                                                                                                                      %          V       [xޤ     �      &   >          try:   5      guess[0] = int( raw_input("\tFirst number: ") )             if not guess[0] in valid:   $        print "\nThat's not 0 or 1."           print "\nTry again.\n"           continue           except:   "      print "\nThat's not 0 or 1."         print "\nTry again.\n"         continue5�_�                    '        ����                                                                                                                                                                                                                                                                                                                            '          3          V       [xީ     �   &   '              try:   6      guess[1] = int( raw_input("\tSecond number: ") )       except:   "      print "\nThat's not 0 or 1."         print "\nStart over.\n"           if not guess[1] in valid:   "      print "\nThat's not 0 or 1."         print "\nStart over.\n"         continue           if guess != answer:          print "\nNo. Try again.\n"5�_�                       %    ����                                                                                                                                                                                                                                                                                                                               %          +       v   +    [xޯ   $ �         1      7        guess[0] = int( raw_input("\tFirst number: ") )5�_�                       +    ����                                                                                                                                                                                                                                                                                                                               %          +       v   +    [xޱ   % �         1      1        guess[0] = int( raw_input("\tNumber: ") )5�_�                       1    ����                                                                                                                                                                                                                                                                                                                               %          +       v   +    [x޶   ) �         1      4        guess[0] = int( raw_input("\tNumber #1: ") )5�_�                           ����                                                                                                                                                                                                                                                                                                                               %          +       v   +    [x޾   * �         1      >        guess[0] = int( raw_input("\tNumber #1: " % (ind+1)) )5�_�                        
    ����                                                                                                                                                                                                                                                                                                                               %          +       v   +    [x��   - �      !   1                continue5�_�                    %       ����                                                                                                                                                                                                                                                                                                                               %          +       v   +    [x��   . �   $   &   1              continue5�_�                           ����                                                                                                                                                                                                                                                                                                                                                v       [x��   1 �          1                 print "\nTry again.\n"5�_�                           ����                                                                                                                                                                                                                                                                                                                                                v       [x��   4 �         1      !        if not guess[0] in valid:5�_�                    $       ����                                                                                                                                                                                                                                                                                                                            $          $          v       [x��   : �   #   %   1              print "\nTry again.\n"5�_�                           ����                                                                                                                                                                                                                                                                                                                            $          $          v       [x��   ; �      !   2      
          �      !   1    5�_�                         
    ����                                                                                                                                                                                                                                                                                                                            %          %          v       [x��     �                           guess5�_�      !                  
    ����                                                                                                                                                                                                                                                                                                                            $          $          v       [x��     �      !   1    �          1    5�_�       "           !           ����                                                                                                                                                                                                                                                                                                                            %          %          v       [x��     �      !   2        guess = [-1,-1,-1,-1]5�_�   !   #           "           ����                                                                                                                                                                                                                                                                                                                            %          %          v       [x��     �      !   2          guess = [-1,-1,-1,-1]5�_�   "   $           #           ����                                                                                                                                                                                                                                                                                                                            %          %          v       [x��     �      !   2            guess = [-1,-1,-1,-1]5�_�   #   %           $           ����                                                                                                                                                                                                                                                                                                                            %          %          v       [x��     �      !   2              guess = [-1,-1,-1,-1]5�_�   $   &           %   %   
    ����                                                                                                                                                                                                                                                                                                                            %          %          v       [x��     �   %   '   2    �   %   &   2    5�_�   %   '           &   &   
    ����                                                                                                                                                                                                                                                                                                                            %          %          v       [x��   = �   %   '   3                guess = [-1,-1,-1,-1]5�_�   &   (           '      	    ����                                                                                                                                                                                                                                                                                                                            %          %          v       [x��   > �         3    5�_�   '   )           (           ����                                                                                                                                                                                                                                                                                                                            &          &          v       [x�     �                 5�_�   (   *           )          ����                                                                                                                                                                                                                                                                                                                            %          %          v       [x�   ? �         4              �         3    5�_�   )   +           *          ����                                                                                                                                                                                                                                                                                                                            &          &          v       [x�     �                        5�_�   *   ,           +      /    ����                                                                                                                                                                                                                                                                                                                            %          %          v       [x�	   C �         3      @        guess[ind] = int( raw_input("\tNumber #1: " % (ind+1)) )5�_�   +   -           ,          ����                                                                                                                                                                                                                                                                                                                            %          %          v       [x�   D �         3        valid = range(0,1)5�_�   ,   .           -      
    ����                                                                                                                                                                                                                                                                                                                            %          %          v       [x�   G �         3        valid = range(0,2)5�_�   -   /           .   '       ����                                                                                                                                                                                                                                                                                                                            %          %          v       [x�K   H �   '   *   4            �   '   )   3    5�_�   .               /   )       ����                                                                                                                                                                                                                                                                                                                            %          %          v       [x�U   K �   )   +   6            �   )   +   5    5��