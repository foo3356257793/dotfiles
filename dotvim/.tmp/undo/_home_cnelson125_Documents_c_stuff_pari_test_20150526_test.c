Vim�UnDo� �L(�GCL.;AIH����'\O�V�����.�d   (                 !       !   !   !    Uf,X    _�                             ����                                                                                                                                                                                                                                                                                                                                                             Ud��    �         %    5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             Ud��     �   $   &          	return 0;�   #   %          pari_close();�   "   $          6pari_printf("gcd = %Ps\nu = %Ps\nv = %Ps\n", d, u, v);�   !   #          d = extgcd(x, y, &u, &v);�       "          *printf("y = "); y = gp_read_stream(stdin);�      !          *printf("x = "); x = gp_read_stream(stdin);�                 pari_init(1000000,2);�                GEN x, y, d, u, v;�                int�                'gerepileall(av, 3, &a, U, V); return a;�                ,*V = diviiexact( subii(a, mulii(A,ux)), B );�                *U = ux;�                }�                ux = v; a = b; b = r;�                vx = subii(ux, mulii(q, vx));�                $GEN r, q = dvmdii(a, b, &r), v = vx;�                {�                while (!gequal0(b))�                1if (signe(a) < 0) { a = negi(a); ux = negi(ux); }�                /if (typ(b) != t_INT) pari_err_TYPE("extgcd",b);�                /if (typ(a) != t_INT) pari_err_TYPE("extgcd",a);�                )GEN ux = gen_1, vx = gen_0, a = A, b = B;�                pari_sp av = avma;�      
          GEN�                */�                8GP;install("extgcd", "GG&&", "gcdex", "./libextgcd.so");5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             Ud��    �         &    5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             Ud��     �         '          int   main()5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             Ud��     �         &          int main()5�_�                    	        ����                                                                                                                                                                                                                                                                                                                                                             Ud��    �      
   &          GEN5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             Ud��    �      !   '          �      !   &    5�_�      	                     ����                                                                                                                                                                                                                                                                                                                                                             Ud��    �      !   '    5�_�      
           	   &       ����                                                                                                                                                                                                                                                                                                                                                             Ud��    �   &   (   (    5�_�   	              
   '        ����                                                                                                                                                                                                                                                                                                                                                             Ud��    �   &   (   *          �   &   (   )    5�_�   
                    	    ����                                                                                                                                                                                                                                                                                                                                                             Ud��   	 �      
   +       �      
   *    5�_�                    	       ����                                                                                                                                                                                                                                                                                                                                                             Ud��   
 �   	      +    5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             Ud��    �         -       �         ,    5�_�                    %       ����                                                                                                                                                                                                                                                                                                                                                             Ud��     �   $   %          	    #if 05�_�                    &       ����                                                                                                                                                                                                                                                                                                                                                             Ud��    �   &   (   -    �   &   '   -    5�_�                    '       ����                                                                                                                                                                                                                                                                                                                                                             Ud�     �   &   '          	    #if 05�_�                    '       ����                                                                                                                                                                                                                                                                                                                                                             Ud�     �   '   )   -    �   '   (   -    5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             Ud�     �                #endif5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             Ud�     �         -    �         -    5�_�                   	        ����                                                                                                                                                                                                                                                                                                                                                             Ud�     �      	          #if 05�_�                            ����                                                                                                                                                                                                                                                                                                                                                             Ud�    �         -    �         -    5�_�                    (        ����                                                                                                                                                                                                                                                                                                                                                             Ud�&     �   '   (          	    #if 05�_�                    *       ����                                                                                                                                                                                                                                                                                                                                                             Ud�'    �   )   *          
    #endif5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             Ud�2     �                #endif5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             Ud�3     �                #if 05�_�                           ����                                                                                                                                                                                                                                                                                                                                                             Ud�;    �         +          �         *    5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             Ud�@    �         ,          �         +    5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             Uf,@     �             (   /*   ;   GP;install("extgcd", "GG&&", "gcdex", "./libextgcd.so");      */   A/* return d = gcd(a,b), sets u, v such that au + bv = gcd(a,b) */       GEN   $extgcd(GEN A, GEN B, GEN *U, GEN *V)   {       pari_sp av = avma;   	    #if 0   -    GEN ux = gen_1, vx = gen_0, a = A, b = B;   3    if (typ(a) != t_INT) pari_err_TYPE("extgcd",a);   3    if (typ(b) != t_INT) pari_err_TYPE("extgcd",b);   5    if (signe(a) < 0) { a = negi(a); ux = negi(ux); }       while (!gequal0(b))       {   ,        GEN r, q = dvmdii(a, b, &r), v = vx;   %        vx = subii(ux, mulii(q, vx));           ux = v; a = b; b = r;       }       *U = ux;   0    *V = diviiexact( subii(a, mulii(A,ux)), B );   +    gerepileall(av, 3, &a, U, V); return a;   
    #endif   }           
int main()   {       GEN x, y, d, u, v;       pari_init(1000000,2);       .    printf("x = "); x = gp_read_stream(stdin);   .    printf("y = "); y = gp_read_stream(stdin);       d = extgcd(x, y, &u, &v);   :    pari_printf("gcd = %Ps\nu = %Ps\nv = %Ps\n", d, u, v);       pari_close();           return 0;   }5�_�                             ����                                                                                                                                                                                                                                                                                                                                                             Uf,F    �   (   *            return 0;�   '   )            pari_close();�   &   (          8  pari_printf("gcd = %Ps\nu = %Ps\nv = %Ps\n", d, u, v);�   %   '            d = extgcd(x, y, &u, &v);�   $   &          ,  printf("y = "); y = gp_read_stream(stdin);�   #   %          ,  printf("x = "); x = gp_read_stream(stdin);�   "   $            pari_init(1000000,2);�   !   #            GEN x, y, d, u, v;�                 int�                )  gerepileall(av, 3, &a, U, V); return a;�                .  *V = diviiexact( subii(a, mulii(A,ux)), B );�                
  *U = ux;�                  }�                    ux = v; a = b; b = r;�                !    vx = subii(ux, mulii(q, vx));�                (    GEN r, q = dvmdii(a, b, &r), v = vx;�                  {�                  while (!gequal0(b))�                3  if (signe(a) < 0) { a = negi(a); ux = negi(ux); }�                1  if (typ(b) != t_INT) pari_err_TYPE("extgcd",b);�                1  if (typ(a) != t_INT) pari_err_TYPE("extgcd",a);�                +  GEN ux = gen_1, vx = gen_0, a = A, b = B;�                  pari_sp av = avma;�   	             GEN�                */�                8GP;install("extgcd", "GG&&", "gcdex", "./libextgcd.so");�               �               5�_�      !                       ����                                                                                                                                                                                                                                                                                                                                                             Uf,V     �                 #include <stdio.h>5�_�                   !           ����                                                                                                                                                                                                                                                                                                                                                             Uf,W    �                 #include <stdlib.h>5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             Ud�
     �   
           5�_�                             ����                                                                                                                                                                                                                                                                                                                                                             Ud�     �         -    �         -      GEN�                    GEN5��