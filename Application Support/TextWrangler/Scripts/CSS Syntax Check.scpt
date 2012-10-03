FasdUAS 1.101.10   ��   ��    k             l      ��  ��   
CSS Syntax Checker for TextWrangler
John Gruber
http://daringfireball.net/projects/csschecker/

Version: 1.0.1
Date: 24 October 2005

This AppleScript is released under a Creative Commons Attribution-ShareAlike License:
<http://creativecommons.org/licenses/by-sa/2.0/>

     � 	 	 
 C S S   S y n t a x   C h e c k e r   f o r   T e x t W r a n g l e r 
 J o h n   G r u b e r 
 h t t p : / / d a r i n g f i r e b a l l . n e t / p r o j e c t s / c s s c h e c k e r / 
 
 V e r s i o n :   1 . 0 . 1 
 D a t e :   2 4   O c t o b e r   2 0 0 5 
 
 T h i s   A p p l e S c r i p t   i s   r e l e a s e d   u n d e r   a   C r e a t i v e   C o m m o n s   A t t r i b u t i o n - S h a r e A l i k e   L i c e n s e : 
 < h t t p : / / c r e a t i v e c o m m o n s . o r g / l i c e n s e s / b y - s a / 2 . 0 / > 
 
   
  
 l     ��������  ��  ��        l     ��  ��    A ; This global is used to track the line number offset of CSS     �   v   T h i s   g l o b a l   i s   u s e d   t o   t r a c k   t h e   l i n e   n u m b e r   o f f s e t   o f   C S S      l     ��  ��    = 7 in inline <style>...</style> tags in an HTML document:     �   n   i n   i n l i n e   < s t y l e > . . . < / s t y l e >   t a g s   i n   a n   H T M L   d o c u m e n t :      p         ������ 0 g_line_offset  ��        l     ��������  ��  ��        l     ��  ��    7 1 Binary-coded decimal of applescript version 1.10     �   b   B i n a r y - c o d e d   d e c i m a l   o f   a p p l e s c r i p t   v e r s i o n   1 . 1 0     !   j     �� "�� "0 as_version_1_10 AS_VERSION_1_10 " m     ���� � !  # $ # l     ��������  ��  ��   $  % & % i     ' ( ' I     ������
�� .aevtoappnull  �   � ****��  ��   ( k      ) )  * + * l     �� , -��   , E ? The run handler is called when the script is invoked normally,    - � . . ~   T h e   r u n   h a n d l e r   i s   c a l l e d   w h e n   t h e   s c r i p t   i s   i n v o k e d   n o r m a l l y , +  / 0 / l     �� 1 2��   1 0 * such as from TextWrangler's Scripts menu.    2 � 3 3 T   s u c h   a s   f r o m   T e x t W r a n g l e r ' s   S c r i p t s   m e n u . 0  4�� 4 n     5 6 5 I    �������� $0 check_css_syntax check_CSS_syntax��  ��   6  f     ��   &  7 8 7 l     ��������  ��  ��   8  9 : 9 l     ��������  ��  ��   :  ; < ; i    
 = > = I      �������� 0 
menuselect  ��  ��   > k     ) ? ?  @ A @ l     �� B C��   B F @ The menuselect() handler gets called when the script is invoked    C � D D �   T h e   m e n u s e l e c t ( )   h a n d l e r   g e t s   c a l l e d   w h e n   t h e   s c r i p t   i s   i n v o k e d A  E F E l     �� G H��   G ) # by TextWrangler as a menu script.     H � I I F   b y   T e x t W r a n g l e r   a s   a   m e n u   s c r i p t .   F  J�� J O     ) K L K Q    ( M N�� M Z     O P�� Q O l    R���� R =    S T S n     U V U 1    ��
�� 
SoLn V 4    �� W
�� 
cwin W m   	 
����  T m     X X � Y Y  C S S��  ��   P k     Z Z  [ \ [ l   �� ] ^��   ] 5 / It's a CSS file, so tell TextWrangler *not* to    ^ � _ _ ^   I t ' s   a   C S S   f i l e ,   s o   t e l l   T e x t W r a n g l e r   * n o t *   t o \  ` a ` l   �� b c��   b + % continue with its HTML syntax check:    c � d d J   c o n t i n u e   w i t h   i t s   H T M L   s y n t a x   c h e c k : a  e f e n    g h g I    �������� $0 check_css_syntax check_CSS_syntax��  ��   h  f     f  i�� i L     j j m    ��
�� boovtrue��  ��   Q L     k k m    ��
�� boovfals N R      ������
�� .ascrerr ****      � ****��  ��  ��   L m      l l�                                                                                  !Rch  alis    f  Macintosh HD               ȧ�H+  a��TextWrangler.app                                               서���        ����  	                Applications    ȧ       �ďP    a��  +Macintosh HD:Applications: TextWrangler.app   "  T e x t W r a n g l e r . a p p    M a c i n t o s h   H D  Applications/TextWrangler.app   / ��  ��   <  m n m l     ��������  ��  ��   n  o p o l     ��������  ��  ��   p  q r q i     s t s I      �������� $0 check_css_syntax check_CSS_syntax��  ��   t k    � u u  v w v l     ��������  ��  ��   w  x y x r      z { z m     ����   { o      ���� 0 g_line_offset   y  | } | r     ~  ~ n   	 � � � I    	�������� 0 get_css_path get_CSS_path��  ��   �  f      o      ���� 0 css_path   }  � � � l    � � � � Z    � ����� � =    � � � o    ���� 0 css_path   � m     � � � � �   � L    ����  ��  ��   � < 6 Don't proceed if we don't have a path to the css file    � � � � l   D o n ' t   p r o c e e d   i f   w e   d o n ' t   h a v e   a   p a t h   t o   t h e   c s s   f i l e �  � � � l   ��������  ��  ��   �  � � � Q    1 � � � � r    $ � � � n   " � � � I    "�� ����� @0 screenscrape_w3c_css_validator screenscrape_W3C_CSS_validator �  ��� � o    ���� 0 css_path  ��  ��   �  f     � o      ���� 0 check_result   � R      �� � �
�� .ascrerr ****      � **** � o      ���� 0 err_text   � �� ���
�� 
errn � o      ���� 0 err_num  ��   � I  , 1�� ���
�� .sysodlogaskr        TEXT � o   , -���� 0 err_text  ��   �  � � � l  2 2��������  ��  ��   �  � � � r   2 6 � � � J   2 4����   � o      ���� 0 css_error_list   �  � � � l  7 7��������  ��  ��   �  ��� � O   7� � � � k   ;� � �  � � � r   ; C � � � n   ; A � � � m   ? A��
�� 
file � 4   ; ?�� �
�� 
TxtW � m   = >����  � o      ���� 0 current_file   �  � � � r   D N � � � n   D L � � � 1   J L��
�� 
pnam � n   D J � � � m   H J��
�� 
docu � 4   D H�� �
�� 
TxtW � m   F G����  � o      ���� 0 document_name   �  � � � l  O O��������  ��  ��   �  � � � Z   O g � ����� � C   O R � � � o   O P���� 0 check_result   � m   P Q � � � � � 2 N o   s y n t a x   e r r o r s   d e t e c t e d � k   U c � �  � � � n  U ` � � � I   V `�� ����� 0 
show_alert   �  � � � m   V W � � � � �  C S S   S y n t a x   O K �  ��� � b   W \ � � � b   W Z � � � l 	 W X ����� � m   W X � � � � � R N o   C S S   e r r o r s   o r   w a r n i n g s   w e r e   f o u n d   i n  ����  ��   � o   X Y���� 0 document_name   � m   Z [ � � � � � �� .��  ��   �  f   U V �  ��� � L   a c����  ��  ��  ��   �  � � � l  h h����~��  �  �~   �  � � � l  h h�} � ��}   � 0 * Put together the results for the browser:    � � � � T   P u t   t o g e t h e r   t h e   r e s u l t s   f o r   t h e   b r o w s e r : �  � � � X   h� ��| � � Z   � � ��{�z � >  � � � � � l  � � ��y�x � c   � � � � � o   � ��w�w 0 err   � m   � ��v
�v 
ctxt�y  �x   � m   � � � � � � �   � k   �{ � �  � � � Q   � � � � � � Z   � � � � � � � =  � � � � � l  � � ��u�t � n   � � � � � 4   � ��s �
�s 
cwor � m   � ��r�r  � o   � ��q�q 0 err  �u  �t   � m   � � � � � � � 
 E r r o r � r   � �   m   � ��p
�p ErslErr  o      �o�o 0 my_kind   �  =  � � l  � ��n�m n   � � 4   � ��l	
�l 
cwor	 m   � ��k�k  o   � ��j�j 0 err  �n  �m   m   � �

 �  W a r n i n g �i r   � � m   � ��h
�h ErslWrng o      �g�g 0 my_kind  �i   � r   � � m   � � �  U n k n o w n o      �f�f 0 my_kind   � R      �e�d�c
�e .ascrerr ****      � ****�d  �c   � r   � � m   � � �  U n k n o w n o      �b�b 0 my_kind   �  l  � ��a�`�_�a  �`  �_   �^ Z   �{�]�\ >  � � o   � ��[�[ 0 my_kind   m   � � �  U n k n o w n k   �w   !"! r   � �#$# n  � �%&% 1   � ��Z
�Z 
txdl& 1   � ��Y
�Y 
ascr$ o      �X�X 0 
old_delims  " '(' r   � �)*) J   � �++ ,�W, 1   � ��V
�V 
tab �W  * n     -.- 1   � ��U
�U 
txdl. 1   � ��T
�T 
ascr( /0/ r   � �121 n   � �343 4   � ��S5
�S 
citm5 m   � ��R�R 4 o   � ��Q�Q 0 err  2 o      �P�P 0 err_description  0 676 r   � �898 o   � ��O�O 0 
old_delims  9 n     :;: 1   � ��N
�N 
txdl; 1   � ��M
�M 
ascr7 <=< l  � ��L�K�J�L  �K  �J  = >?> Q   �@AB@ r  CDC c  EFE n  GHG 4  �II
�I 
cworI m  �H�H H o  �G�G 0 err  F m  �F
�F 
longD o      �E�E 0 line_num  A R      �D�C�B
�D .ascrerr ****      � ****�C  �B  B r  JKJ m  �A�A K o      �@�@ 0 line_num  ? LML l �?�>�=�?  �>  �=  M NON l �<PQ�<  P F @ Account for line offset if we're checking CSS in a <style> tag:   Q �RR �   A c c o u n t   f o r   l i n e   o f f s e t   i f   w e ' r e   c h e c k i n g   C S S   i n   a   < s t y l e >   t a g :O STS r  UVU [  WXW o  �;�; 0 line_num  X o  �:�: 0 g_line_offset  V o      �9�9 0 line_num  T YZY l   �8�7�6�8  �7  �6  Z [\[ r   6]^] n   4_`_ 1  04�5
�5 
Ofse` n   0aba 4 +0�4c
�4 
cha c m  ./�3�3 b n   +ded 4  &+�2f
�2 
clinf o  )*�1�1 0 line_num  e 4   &�0g
�0 
cwing m  $%�/�/ ^ o      �.�. 0 s_offset  \ hih r  7Mjkj n  7Klml 1  GK�-
�- 
Ofsem n  7Gnon 4 BG�,p
�, 
cha p m  EF�+�+��o n  7Bqrq 4  =B�*s
�* 
clins o  @A�)�) 0 line_num  r 4  7=�(t
�( 
cwint m  ;<�'�' k o      �&�& 0 e_offset  i uvu r  Nrwxw K  Npyy �%z{
�% 
Erslz l 	QR|�$�#| o  QR�"�" 0 my_kind  �$  �#  { �!}~
�! 
Efil} l 	UV� � o  UV�� 0 current_file  �   �  ~ ���
� 
Elin� l 	YZ���� o  YZ�� 0 line_num  �  �  � ���
� 
Estr� l ]`���� \  ]`��� o  ]^�� 0 s_offset  � m  ^_�� �  �  � ���
� 
Eend� o  cd�� 0 e_offset  � ���
� 
Etxt� c  gl��� l 	gh���� o  gh�� 0 err_description  �  �  � m  hk�
� 
ctxt�  x o      �� 0 err_list_item  v ��� s  sw��� o  st�
�
 0 err_list_item  � n      ���  ;  uv� o  tu�	�	 0 css_error_list  �  �]  �\  �^  �{  �z  �| 0 err   � l  k p���� n   k p��� 2   l p�
� 
cpar� o   k l�� 0 check_result  �  �   � ��� l ������  �  �  � ��� I ���� �
� .corecrel****      � null�   � ����
�� 
kocl� m  ����
�� 
RslW� ����
�� 
data� o  ������ 0 css_error_list  � �����
�� 
prdt� K  ���� �����
�� 
pnam� m  ���� ��� " C S S   S y n t a x   E r r o r s��  ��  � ���� l ����������  ��  ��  ��   � m   7 8���                                                                                  !Rch  alis    f  Macintosh HD               ȧ�H+  a��TextWrangler.app                                               서���        ����  	                Applications    ȧ       �ďP    a��  +Macintosh HD:Applications: TextWrangler.app   "  T e x t W r a n g l e r . a p p    M a c i n t o s h   H D  Applications/TextWrangler.app   / ��  ��   r ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� i    ��� I      �������� 0 get_css_path get_CSS_path��  ��  � k    ��� ��� l     ������  �   Input: None   � ���    I n p u t :   N o n e� ��� l     ������  �  	 Returns:   � ���    R e t u r n s :� ��� l     ������  � K E	Path to the CSS file to be passed to the validator. Returns an empty   � ��� � 	 P a t h   t o   t h e   C S S   f i l e   t o   b e   p a s s e d   t o   t h e   v a l i d a t o r .   R e t u r n s   a n   e m p t y� ��� l     ������  � J D	string if an error occurs or if the frontmost window is an untitled   � ��� � 	 s t r i n g   i f   a n   e r r o r   o c c u r s   o r   i f   t h e   f r o n t m o s t   w i n d o w   i s   a n   u n t i t l e d� ��� l     ������  � N H	document. If a temp file needs to be written, this is where it happens.   � ��� � 	 d o c u m e n t .   I f   a   t e m p   f i l e   n e e d s   t o   b e   w r i t t e n ,   t h i s   i s   w h e r e   i t   h a p p e n s .� ��� O    ���� k   ��� ��� Q    P���� k    0�� ��� l   ������  � ; 5 Make sure the frontmost window is a text window, and   � ��� j   M a k e   s u r e   t h e   f r o n t m o s t   w i n d o w   i s   a   t e x t   w i n d o w ,   a n d� ��� l   ������  � 9 3 that it is not an untitled (never saved) document.   � ��� f   t h a t   i t   i s   n o t   a n   u n t i t l e d   ( n e v e r   s a v e d )   d o c u m e n t .� ��� r    ��� 4    ���
�� 
cwin� m   	 
���� � o      ���� 0 w  � ��� Z   ������� l   ������ >   ��� n    ��� m    ��
�� 
pcls� o    ���� 0 w  � m    ��
�� 
TxtW��  ��  � R    ������
�� .ascrerr ****      � ****��  ��  ��  ��  � ���� Z   0������� H    #�� l   "������ n    "��� 1     "��
�� 
oDsk� o     ���� 0 w  ��  ��  � R   & ,�����
�� .ascrerr ****      � ****��  � �����
�� 
errn� m   ( )����'��  ��  ��  ��  � R      �����
�� .ascrerr ****      � ****��  � �����
�� 
errn� o      ���� 0 n  ��  � k   8 P�� ��� l  8 8������  � H B As of TextWrangler 2.1, result browser entries must be associated   � ��� �   A s   o f   T e x t W r a n g l e r   2 . 1 ,   r e s u l t   b r o w s e r   e n t r i e s   m u s t   b e   a s s o c i a t e d� ��� l  8 8������  �   with a file on disk.   � �   *   w i t h   a   f i l e   o n   d i s k .�  Z   8 M�� l  8 ;���� =   8 ; o   8 9���� 0 n   m   9 :����'��  ��   n  > E	
	 I   ? E������ 0 show_warning    m   ? @ � R C S S   S y n t a x   C h e c k :   u n t i t l e d   d o c u m e n t   e r r o r �� l 	 @ A���� m   @ A � � C S S   S y n t a x   C h e c k   d o e s   n o t   w o r k   w i t h   u n t i t l e d   d o c u m e n t s .   S a v e   y o u r   d o c u m e n t ,   t h e n   t r y   a g a i n .��  ��  ��  ��  
  f   > ?��   I  H M������
�� .sysobeepnull��� ��� long��  ��   �� l  N P L   N P m   N O �   1 + Don't proceed with the rest of the script.    � V   D o n ' t   p r o c e e d   w i t h   t h e   r e s t   o f   t h e   s c r i p t .��  �  l  Q Q��������  ��  ��    r   Q V !  n   Q T"#" 1   R T��
�� 
imod# o   Q R���� 0 w  ! o      ���� 0 is_dirty   $%$ r   W `&'& l  W ^(����( n   W ^)*) 1   Z ^��
�� 
LinB* n   W Z+,+ m   X Z��
�� 
docu, o   W X���� 0 w  ��  ��  ' o      ���� 0 
linebreaks  % -.- l  a a��������  ��  ��  . /0/ l  a a��12��  1 / ) Search for a <style>...</style> tag pair   2 �33 R   S e a r c h   f o r   a   < s t y l e > . . . < / s t y l e >   t a g   p a i r0 454 r   a u676 K   a s88 ��9:
�� 
SMod9 m   d g��
�� SModGrep: ��;<
�� 
STop; m   j k��
�� boovtrue< ��=��
�� 
Rrsl= m   n o��
�� boovtrue��  7 o      ���� 
0 s_opts  5 >?> r   v �@A@ I  v ���BC
�� .R*chFindMtch���     TEXTB l 	 v yD����D m   v yEE �FF : ( ? s ) < s t y l e [ ^ > ] * > ( . + ? ) < / s t y l e >��  ��  C ��GH
�� 
FnInG n   | �IJI 4   � ���K
�� 
ctxtK l 
 � �L����L m   � ����� ��  ��  J 4   | ���M
�� 
TxtDM m   � ����� H ��NO
�� 
OptsN o   � ����� 
0 s_opts  O ��P��
�� 
SelMP m   � ���
�� boovfals��  A o      ���� 0 style_tag_match  ? QRQ l  � ���������  ��  ��  R S��S Z   ��TUVWT l  � �X����X F   � �YZY l  � �[����[ >  � �\]\ n   � �^_^ 1   � ���
�� 
SoLn_ o   � ����� 0 w  ] m   � �`` �aa  C S S��  ��  Z l  � �b����b n   � �cdc 1   � ���
�� 
Fnd?d o   � ����� 0 style_tag_match  ��  ��  ��  ��  U k   �-ee fgf l  � ��hi�  h L F If it's not a CSS document and there is a <style> tag, just check the   i �jj �   I f   i t ' s   n o t   a   C S S   d o c u m e n t   a n d   t h e r e   i s   a   < s t y l e >   t a g ,   j u s t   c h e c k   t h eg klk l  � ��~mn�~  m "  contents of the <style> tag   n �oo 8   c o n t e n t s   o f   t h e   < s t y l e >   t a gl pqp r   � �rsr I  � ��}�|t
�} .R*chGSubutxt    ��� null�|  t �{u�z
�{ 
RplPu m   � �vv �ww  � 1�z  s o      �y�y 0 style_contents  q xyx l  � ��x�w�v�x  �w  �v  y z{z l  � ��u|}�u  | ] W We need to know which line the "<style>" opening tag ends on (which is not necessarily   } �~~ �   W e   n e e d   t o   k n o w   w h i c h   l i n e   t h e   " < s t y l e > "   o p e n i n g   t a g   e n d s   o n   ( w h i c h   i s   n o t   n e c e s s a r i l y{ � l  � ��t���t  �   the line it starts on:   � ��� .   t h e   l i n e   i t   s t a r t s   o n :� ��� r   � ���� I  � ��s��
�s .R*chFindMtch���     TEXT� m   � ��� ���  < s t y l e [ ^ > ] * >� �r��
�r 
FnIn� n   � ���� 4   � ��q�
�q 
ctxt� m   � ��p�p � 4   � ��o�
�o 
TxtD� m   � ��n�n � �m��
�m 
Opts� o   � ��l�l 
0 s_opts  � �k��j
�k 
SelM� m   � ��i
�i boovfals�j  � o      �h�h 0 style_match  � ��� r   � ���� n   � ���� 1   � ��g
�g 
pALL� n   � ���� 1   � ��f
�f 
MSpc� o   � ��e�e 0 style_match  � o      �d�d 0 	tag_props  � ��� r   � ���� \   � ���� l  � ���c�b� n   � ���� 1   � ��a
�a 
ELin� o   � ��`�` 0 	tag_props  �c  �b  � m   � ��_�_ � o      �^�^ 0 g_line_offset  � ��� l  � ��]�\�[�]  �\  �[  � ��� l  � ��Z���Z  � O I Write just the CSS contents of the <style>...</style> tag to a temp file   � ��� �   W r i t e   j u s t   t h e   C S S   c o n t e n t s   o f   t h e   < s t y l e > . . . < / s t y l e >   t a g   t o   a   t e m p   f i l e� ��� r   ���� l  � ��Y�X� I  � �W��V
�W .earsffdralis        afdr� m   � ��U
�U afdmtemp�V  �Y  �X  � o      �T�T 0 tmp  � ��� r  ��� b  ��� l ��S�R� c  ��� o  �Q�Q 0 tmp  � m  �P
�P 
TEXT�S  �R  � n  ��� 1  �O
�O 
pnam� 4  �N�
�N 
cwin� m  
�M�M � o      �L�L 0 tmp_file  � ��� n ��� I  �K��J�K (0 write_file_as_utf8 write_file_as_UTF8� ��� o  �I�I 0 tmp_file  � ��H� o  �G�G 0 style_contents  �H  �J  �  f  � ��� r  +��� n  )��� 1  %)�F
�F 
strq� n  %��� 1  !%�E
�E 
psxp� l !��D�C� c  !��� o  �B�B 0 tmp_file  � m   �A
�A 
alis�D  �C  � o      �@�@ 0 css_path  � ��?� l ,,�>�=�<�>  �=  �<  �?  V ��� G  0=��� l 01��;�:� o  01�9�9 0 is_dirty  �;  �:  � l 49��8�7� > 49��� o  45�6�6 0 
linebreaks  � m  58�5
�5 LinBLF  �8  �7  � ��4� k  @v�� ��� r  @I��� l @G��3�2� I @G�1��0
�1 .earsffdralis        afdr� m  @C�/
�/ afdmtemp�0  �3  �2  � o      �.�. 0 tmp  � ��� r  JZ��� b  JX��� l JO��-�,� c  JO��� o  JK�+�+ 0 tmp  � m  KN�*
�* 
TEXT�-  �,  � n  OW��� 1  SW�)
�) 
pnam� 4  OS�(�
�( 
cwin� m  QR�'�' � o      �&�& 0 tmp_file  � ��� n [f��� I  \f�%��$�% (0 write_file_as_utf8 write_file_as_UTF8� ��� o  \]�#�# 0 tmp_file  � ��"� n  ]b��� m  ^b�!
�! 
ctxt� o  ]^� �  0 w  �"  �$  �  f  [\� ��� r  gv��� n  gt��� 1  pt�
� 
strq� n  gp��� 1  lp�
� 
psxp� l gl ��  c  gl o  gh�� 0 tmp_file   m  hk�
� 
alis�  �  � o      �� 0 css_path  �  �4  W r  y� n  y� 1  ���
� 
strq n  y� 1  ���
� 
psxp l y�	��	 c  y�

 n  y~ m  z~�
� 
file o  yz�� 0 w   m  ~��
� 
alis�  �   o      �� 0 css_path  ��  � m     �                                                                                  !Rch  alis    f  Macintosh HD               ȧ�H+  a��TextWrangler.app                                               서���        ����  	                Applications    ȧ       �ďP    a��  +Macintosh HD:Applications: TextWrangler.app   "  T e x t W r a n g l e r . a p p    M a c i n t o s h   H D  Applications/TextWrangler.app   / ��  � � L  �� o  ���� 0 css_path  �  �  l     ����  �  �    l     �
�	��
  �	  �    l     ����  �  �    i     I      ��� @0 screenscrape_w3c_css_validator screenscrape_W3C_CSS_validator � o      �� 0 css_path  �  �   k     �  l     �  !�     3 - Input: Quoted form of posix path of css file   ! �"" Z   I n p u t :   Q u o t e d   f o r m   o f   p o s i x   p a t h   o f   c s s   f i l e #$# l     ��%&��  % M G Returns: Screenscraped results from validator in the following format:   & �'' �   R e t u r n s :   S c r e e n s c r a p e d   r e s u l t s   f r o m   v a l i d a t o r   i n   t h e   f o l l o w i n g   f o r m a t :$ ()( l     ��������  ��  ��  ) *+* l     ��������  ��  ��  + ,-, l     ��./��  . ? 9 Find the "CSS Check Syntax.pl" Perl script; assume it is   / �00 r   F i n d   t h e   " C S S   C h e c k   S y n t a x . p l "   P e r l   s c r i p t ;   a s s u m e   i t   i s- 121 l     ��34��  3 @ : in the same folder as this AppleScript file. On 10.4 and    4 �55 t   i n   t h e   s a m e   f o l d e r   a s   t h i s   A p p l e S c r i p t   f i l e .   O n   1 0 . 4   a n d  2 676 l     ��89��  8 = 7 later, we can use "path to me" to get the path to this   9 �:: n   l a t e r ,   w e   c a n   u s e   " p a t h   t o   m e "   t o   g e t   t h e   p a t h   t o   t h i s7 ;<; l     ��=>��  = G A AppleScript; on 10.3, we'll hard-code the path to TextWrangler's   > �?? �   A p p l e S c r i p t ;   o n   1 0 . 3 ,   w e ' l l   h a r d - c o d e   t h e   p a t h   t o   T e x t W r a n g l e r ' s< @A@ l     ��BC��  B   Scripts folder.   C �DD     S c r i p t s   f o l d e r .A EFE l     ��������  ��  ��  F GHG q      II ��J�� 0 applescript_path  J ��K�� 0 parent_folder  K ������ 0 perl_script_path  ��  H LML l     ��������  ��  ��  M NON Z     vPQ��RP l    S����S @     TUT l    V����V I    ��W��
�� .fndrgstl****    ��� ****W m     XX �YY  a s c v��  ��  ��  U o    
���� "0 as_version_1_10 AS_VERSION_1_10��  ��  Q k    IZZ [\[ l   ��]^��  ] : 4 AppleScript 1.10 or later, (Mac OS X 10.4 or later)   ^ �__ h   A p p l e S c r i p t   1 . 1 0   o r   l a t e r ,   ( M a c   O S   X   1 0 . 4   o r   l a t e r )\ `a` r    bcb I   ��d��
�� .earsffdralis        afdrd  f    ��  c o      ���� 0 applescript_path  a efe l   ��������  ��  ��  f ghg l   ��ij��  i D > If the script is run from Script Editor, "path to me" returns   j �kk |   I f   t h e   s c r i p t   i s   r u n   f r o m   S c r i p t   E d i t o r ,   " p a t h   t o   m e "   r e t u r n sh lml l   ��no��  n $  the path to Script Editor.app   o �pp <   t h e   p a t h   t o   S c r i p t   E d i t o r . a p pm qrq Z    8st����s l   u����u D    vwv l   x����x c    yzy o    ���� 0 applescript_path  z m    ��
�� 
ctxt��  ��  w m    {{ �|| $ S c r i p t   E d i t o r . a p p :��  ��  t k    4}} ~~ O   +��� r   " *��� n   " (��� 1   & (��
�� 
ppth� 4   " &���
�� 
docu� m   $ %���� � o      ���� 0 applescript_path  � m    ���                                                                                  ToyS  alis    �  Macintosh HD               ȧ�H+  a��AppleScript Editor.app                                         d�Gˍ�u        ����  	                	Utilities     ȧ       ˍ4�    a��a��  <Macintosh HD:Applications: Utilities: AppleScript Editor.app  .  A p p l e S c r i p t   E d i t o r . a p p    M a c i n t o s h   H D  -Applications/Utilities/AppleScript Editor.app   / ��   ��� l  , ,������  � J D The following POSIX path to POSIX file coercion doesn't work within   � ��� �   T h e   f o l l o w i n g   P O S I X   p a t h   t o   P O S I X   f i l e   c o e r c i o n   d o e s n ' t   w o r k   w i t h i n� ��� l  , ,������  � + % a tell block (and I don't know why):   � ��� J   a   t e l l   b l o c k   ( a n d   I   d o n ' t   k n o w   w h y ) :� ���� r   , 4��� c   , 2��� 4   , 0���
�� 
psxf� o   . /���� 0 applescript_path  � m   0 1��
�� 
alis� o      ���� 0 applescript_path  ��  ��  ��  r ��� l  9 9��������  ��  ��  � ���� O   9 I��� k   = H�� ��� r   = B��� n   = @��� 1   > @��
�� 
ctnr� o   = >���� 0 applescript_path  � o      ���� 0 parent_folder  � ���� r   C H��� n   C F��� 1   D F��
�� 
posx� o   C D���� 0 parent_folder  � o      ���� 0 parent_folder  ��  � m   9 :���                                                                                  sevs  alis    �  Macintosh HD               ȧ�H+  a��System Events.app                                              d���}Y        ����  	                CoreServices    ȧ       ���    a��a��a��  =Macintosh HD:System: Library: CoreServices: System Events.app   $  S y s t e m   E v e n t s . a p p    M a c i n t o s h   H D  -System/Library/CoreServices/System Events.app   / ��  ��  ��  R k   L v�� ��� l  L L������  � $  AppleScript 1.9.x or earlier.   � ��� <   A p p l e S c r i p t   1 . 9 . x   o r   e a r l i e r .� ��� l  L L��������  ��  ��  � ��� l  L L������  � > 8 For some ungodly reason, this next line can't go in the   � ��� p   F o r   s o m e   u n g o d l y   r e a s o n ,   t h i s   n e x t   l i n e   c a n ' t   g o   i n   t h e� ��� l  L L������  � C = System Events tell block, or it will return the local domain   � ��� z   S y s t e m   E v e n t s   t e l l   b l o c k ,   o r   i t   w i l l   r e t u r n   t h e   l o c a l   d o m a i n� ��� l  L L������  � 2 , app support folder, instead of user domain:   � ��� X   a p p   s u p p o r t   f o l d e r ,   i n s t e a d   o f   u s e r   d o m a i n :� ��� r   L U��� I  L S����
�� .earsffdralis        afdr� m   L M��
�� afdrasup� �����
�� 
from� m   N O��
�� fldmfldu��  � o      ���� 0 app_support  � ���� O   V v��� k   Z u�� ��� r   Z d��� n   Z b��� 4   [ b���
�� 
cobj� m   ^ a�� ���  T e x t W r a n g l e r� o   Z [���� 0 app_support  � o      ���� 0 
tw_support  � ��� r   e o��� n   e m��� 4   f m���
�� 
cobj� m   i l�� ���  S c r i p t s� o   e f���� 0 
tw_support  � o      ���� 0 
tw_scripts  � ���� r   p u��� n   p s��� 1   q s��
�� 
posx� o   p q���� 0 
tw_scripts  � o      ���� 0 parent_folder  ��  � m   V W���                                                                                  sevs  alis    �  Macintosh HD               ȧ�H+  a��System Events.app                                              d���}Y        ����  	                CoreServices    ȧ       ���    a��a��a��  =Macintosh HD:System: Library: CoreServices: System Events.app   $  S y s t e m   E v e n t s . a p p    M a c i n t o s h   H D  -System/Library/CoreServices/System Events.app   / ��  ��  O ��� l  w w��������  ��  ��  � ��� r   w ���� n   w ���� 1   | ���
�� 
strq� l  w |������ b   w |��� o   w x���� 0 parent_folder  � m   x {�� ��� < / . i n t e r n a l / C S S   S y n t a x   C h e c k . p l��  ��  � o      ���� 0 perl_script_path  � ��� l  � �������  � E ? Note: do shell script must run outside tell TextWrangler block   � ��� ~   N o t e :   d o   s h e l l   s c r i p t   m u s t   r u n   o u t s i d e   t e l l   T e x t W r a n g l e r   b l o c k� ��� r   � ���� c   � ���� b   � ���� b   � ���� b   � �   b   � � m   � � �  p e r l 1   � ���
�� 
spac o   � ����� 0 perl_script_path  � 1   � ���
�� 
spac� o   � ����� 0 css_path  � m   � ���
�� 
TEXT� o      ���� 0 my_shell_cmd  �  l  � �	
 L   � � I  � �����
�� .sysoexecTEXT���     TEXT o   � ����� 0 my_shell_cmd  ��  	 $  without altering line endings   
 � <   w i t h o u t   a l t e r i n g   l i n e   e n d i n g s �� l  � ���������  ��  ��  ��    l     ��������  ��  ��    l     ��������  ��  ��    i     I      ������ 0 
show_alert    o      ���� 0 	the_title   �� o      ���� 0 the_message  ��  ��   k     .  Z     +��  l    !���! @     "#" l    $�~�}$ I    �|%�{
�| .fndrgstl****    ��� ****% m     && �''  a s c v�{  �~  �}  # o    
�z�z "0 as_version_1_10 AS_VERSION_1_10��  �   k    (( )*) l   �y+,�y  + ' ! AppleScript 1.10 or later (10.4)   , �-- B   A p p l e S c r i p t   1 . 1 0   o r   l a t e r   ( 1 0 . 4 )* .�x. I   �w/0
�w .sysodisAaleR        TEXT/ o    �v�v 0 	the_title  0 �u1�t
�u 
mesS1 o    �s�s 0 the_message  �t  �x  ��    I   +�r23
�r .sysodlogaskr        TEXT2 b    454 b    676 b    898 o    �q�q 0 	the_title  9 o    �p
�p 
ret 7 o    �o
�o 
ret 5 l 
  :�n�m: o    �l�l 0 the_message  �n  �m  3 �k;<
�k 
btns; J     #== >�j> m     !?? �@@  O K�j  < �iAB
�i 
dfltA m   $ %�h�h B �gC�f
�g 
dispC m   & '�e
�e stic   �f   D�dD L   , .�c�c  �d   EFE l     �b�a�`�b  �a  �`  F GHG l     �_�^�]�_  �^  �]  H IJI i    KLK I      �\M�[�\ 0 show_warning  M NON o      �Z�Z 0 	the_title  O P�YP o      �X�X 0 the_message  �Y  �[  L k     0QQ RSR Z     -TU�WVT l    W�V�UW @     XYX l    Z�T�SZ I    �R[�Q
�R .fndrgstl****    ��� ****[ m     \\ �]]  a s c v�Q  �T  �S  Y o    
�P�P "0 as_version_1_10 AS_VERSION_1_10�V  �U  U k    ^^ _`_ l   �Oab�O  a ' ! AppleScript 1.10 or later (10.4)   b �cc B   A p p l e S c r i p t   1 . 1 0   o r   l a t e r   ( 1 0 . 4 )` d�Nd I   �Mef
�M .sysodisAaleR        TEXTe o    �L�L 0 	the_title  f �Kgh
�K 
mesSg o    �J�J 0 the_message  h �Ii�H
�I 
as Ai m    �G
�G EAlTwarN�H  �N  �W  V I   -�Fjk
�F .sysodlogaskr        TEXTj b    !lml b    non b    pqp o    �E�E 0 	the_title  q o    �D
�D 
ret o o    �C
�C 
ret m l 
   r�B�Ar o     �@�@ 0 the_message  �B  �A  k �?st
�? 
btnss J   " %uu v�>v m   " #ww �xx  O K�>  t �=yz
�= 
dflty m   & '�<�< z �;{�:
�; 
disp{ m   ( )�9
�9 stic   �:  S |�8| L   . 0�7�7  �8  J }~} l     �6�5�4�6  �5  �4  ~ � l     �3�2�1�3  �2  �1  � ��� l     �0�/�.�0  �/  �.  � ��� i    "��� I      �-��,�- (0 write_file_as_utf8 write_file_as_UTF8� ��� o      �+�+ 0 the_file  � ��*� o      �)�) 0 the_content  �*  �,  � k     8�� ��� l     �(���(  � 0 *	the_file: HFS-style path to file to write   � ��� T 	 t h e _ f i l e :   H F S - s t y l e   p a t h   t o   f i l e   t o   w r i t e� ��� l     �'���'  � \ V	the_content: string to write to file; can be Unicode text, will be converted to UTF-8   � ��� � 	 t h e _ c o n t e n t :   s t r i n g   t o   w r i t e   t o   f i l e ;   c a n   b e   U n i c o d e   t e x t ,   w i l l   b e   c o n v e r t e d   t o   U T F - 8� ��� q      �� �&�%�& 0 file_ref  �%  � ��� r     	��� I    �$��
�$ .rdwropenshor       file� o     �#�# 0 the_file  � �"��!
�" 
perm� m    � 
�  boovtrue�!  � o      �� 0 file_ref  � ��� Q   
 8���� k    $�� ��� I   ���
� .rdwrseofnull���     ****� o    �� 0 file_ref  � ���
� 
set2� m    ��  �  � ��� I   ���
� .rdwrwritnull���     ****� o    �� 0 the_content  � ���
� 
refn� o    �� 0 file_ref  � ���
� 
as  � m    �
� 
utf8�  � ��� I   $���
� .rdwrclosnull���     ****� o     �� 0 file_ref  �  �  � R      ���
� .ascrerr ****      � ****� o      �� 0 err_msg  � ���

� 
errn� o      �	�	 0 err_num  �
  � k   , 8�� ��� I  , 1���
� .rdwrclosnull���     ****� o   , -�� 0 file_ref  �  � ��� R   2 8���
� .ascrerr ****      � ****� o   6 7�� 0 err_msg  � ���
� 
errn� o   4 5� �  0 err_num  �  �  �  � ���� l     ��������  ��  ��  ��       ���������������  � 	�������������������� "0 as_version_1_10 AS_VERSION_1_10
�� .aevtoappnull  �   � ****�� 0 
menuselect  �� $0 check_css_syntax check_CSS_syntax�� 0 get_css_path get_CSS_path�� @0 screenscrape_w3c_css_validator screenscrape_W3C_CSS_validator�� 0 
show_alert  �� 0 show_warning  �� (0 write_file_as_utf8 write_file_as_UTF8�� �� �� (��������
�� .aevtoappnull  �   � ****��  ��  �  � ���� $0 check_css_syntax check_CSS_syntax�� )j+  � �� >���������� 0 
menuselect  ��  ��  �  �  l���� X������
�� 
cwin
�� 
SoLn�� $0 check_css_syntax check_CSS_syntax��  ��  �� *� & *�k/�,�  )j+ OeY fW X  hU� �� t���������� $0 check_css_syntax check_CSS_syntax��  ��  � �������������������������������� 0 css_path  �� 0 check_result  �� 0 err_text  �� 0 err_num  �� 0 css_error_list  �� 0 current_file  �� 0 document_name  �� 0 err  �� 0 my_kind  �� 0 
old_delims  �� 0 err_description  �� 0 line_num  �� 0 s_offset  �� 0 e_offset  �� 0 err_list_item  � 7���� ����������������� � � � ������������� ��� ���
��������������������������������������������������� 0 g_line_offset  �� 0 get_css_path get_CSS_path�� @0 screenscrape_w3c_css_validator screenscrape_W3C_CSS_validator�� 0 err_text  � ������
�� 
errn�� 0 err_num  ��  
�� .sysodlogaskr        TEXT
�� 
TxtW
�� 
file
�� 
docu
�� 
pnam�� 0 
show_alert  
�� 
cpar
�� 
kocl
�� 
cobj
�� .corecnte****       ****
�� 
ctxt
�� 
cwor
�� ErslErr 
�� ErslWrng��  ��  
�� 
ascr
�� 
txdl
�� 
tab 
�� 
citm
�� 
long
�� 
cwin
�� 
clin
�� 
cha 
�� 
Ofse
�� 
Ersl
�� 
Efil
�� 
Elin
�� 
Estr
�� 
Eend
�� 
Etxt�� 
�� 
RslW
�� 
data
�� 
prdt�� 
�� .corecrel****      � null���jE�O)j+ E�O��  hY hO )�k+ E�W X  �j OjvE�O�h*�k/�,E�O*�k/�,�,E�O�� )��%�%l+ OhY hO�a -[a a l kh �a &a  � 4�a k/a   
a E�Y �a k/a   
a E�Y a E�W X  a E�O�a   �_ !a ",E�O_ #kv_ !a ",FO�a $l/E�O�_ !a ",FO �a l/a %&E�W 
X  kE�O��E�O*a &k/a '�/a (k/a ),E�O*a &k/a '�/a (i/a ),E�Oa *�a +�a ,�a -�ka .�a /�a &a 0E�O��6GY hY h[OY��O*a a 1a 2�a 3�a 4la 5 6OPU� ������������� 0 get_css_path get_CSS_path��  ��  � �������������������������� 0 w  �� 0 n  �� 0 is_dirty  �� 0 
linebreaks  �� 
0 s_opts  �� 0 style_tag_match  �� 0 style_contents  �� 0 style_match  �� 0 	tag_props  �� 0 tmp  �� 0 tmp_file  �� 0 css_path  � 3�����������������������������������E��������~�}�|`�{�z�yv�x��w�v�u�t�s�r�q�p�o�n�m�l�k�j
�� 
cwin
�� 
pcls
�� 
TxtW
�� 
oDsk
�� 
errn��'��  � �i�h�g
�i 
errn�h 0 n  �g  �� 0 show_warning  
�� .sysobeepnull��� ��� long
�� 
imod
�� 
docu
�� 
LinB
�� 
SMod
�� SModGrep
�� 
STop
�� 
Rrsl�� 
�� 
FnIn
�� 
TxtD
�� 
ctxt
� 
Opts
�~ 
SelM
�} .R*chFindMtch���     TEXT
�| 
SoLn
�{ 
Fnd?
�z 
bool
�y 
RplP
�x .R*chGSubutxt    ��� null
�w 
MSpc
�v 
pALL
�u 
ELin�t 0 g_line_offset  
�s afdmtemp
�r .earsffdralis        afdr
�q 
TEXT
�p 
pnam�o (0 write_file_as_utf8 write_file_as_UTF8
�n 
alis
�m 
psxp
�l 
strq
�k LinBLF  
�j 
file����� .*�k/E�O��,� 	)jhY hO��, )��lhY hW X  ��  )��l+ Y *j O�O��,E�O��,a ,E�Oa a a ea ea E�Oa a *a k/a k/a �a fa  E�O�a ,a 	 �a ,Ea  & �*a !a "l #E�Oa $a *a k/a k/a �a fa  E�O�a %,a &,E�O�a ',kE` (Oa )j *E�O�a +&*�k/a ,,%E�O)��l+ -O�a .&a /,a 0,E�OPY ^�
 �a 1a  & ;a )j *E�O�a +&*�k/a ,,%E�O)��a -l+ -O�a .&a /,a 0,E�Y �a 2,a .&a /,a 0,E�UO�� �f�e�d���c�f @0 screenscrape_w3c_css_validator screenscrape_W3C_CSS_validator�e �b��b �  �a�a 0 css_path  �d  � �`�_�^�]�\�[�Z�Y�` 0 css_path  �_ 0 applescript_path  �^ 0 parent_folder  �] 0 perl_script_path  �\ 0 app_support  �[ 0 
tw_support  �Z 0 
tw_scripts  �Y 0 my_shell_cmd  � X�X�W�V{��U�T�S�R��Q�P�O�N�M�L����K�J�I�H
�X .fndrgstl****    ��� ****
�W .earsffdralis        afdr
�V 
ctxt
�U 
docu
�T 
ppth
�S 
psxf
�R 
alis
�Q 
ctnr
�P 
posx
�O afdrasup
�N 
from
�M fldmfldu
�L 
cobj
�K 
strq
�J 
spac
�I 
TEXT
�H .sysoexecTEXT���     TEXT�c ��j b    @)j E�O��&� � 
*�k/�,E�UO*�/�&E�Y hO� ��,E�O��,E�UY ,���l E�O� �a a /E�O�a a /E�O��,E�UO�a %a ,E�Oa _ %�%_ %�%a &E�O�j OP� �G�F�E���D�G 0 
show_alert  �F �C��C �  �B�A�B 0 	the_title  �A 0 the_message  �E  � �@�?�@ 0 	the_title  �? 0 the_message  � &�>�=�<�;�:?�9�8�7�6�5
�> .fndrgstl****    ��� ****
�= 
mesS
�< .sysodisAaleR        TEXT
�; 
ret 
�: 
btns
�9 
dflt
�8 
disp
�7 stic   �6 
�5 .sysodlogaskr        TEXT�D /�j b    ��l Y ��%�%�%��kv�k��� Oh� �4L�3�2���1�4 0 show_warning  �3 �0��0 �  �/�.�/ 0 	the_title  �. 0 the_message  �2  � �-�,�- 0 	the_title  �, 0 the_message  � \�+�*�)�(�'�&�%�$w�#�"�!� �
�+ .fndrgstl****    ��� ****
�* 
mesS
�) 
as A
�( EAlTwarN�' 
�& .sysodisAaleR        TEXT
�% 
ret 
�$ 
btns
�# 
dflt
�" 
disp
�! stic   �  
� .sysodlogaskr        TEXT�1 1�j b    ����� Y ��%�%�%��kv�k��� Oh� �������� (0 write_file_as_utf8 write_file_as_UTF8� ��� �  ��� 0 the_file  � 0 the_content  �  � ������ 0 the_file  � 0 the_content  � 0 file_ref  � 0 err_msg  � 0 err_num  � ���������
�	���
� 
perm
� .rdwropenshor       file
� 
set2
� .rdwrseofnull���     ****
� 
refn
� 
as  
� 
utf8� 
�
 .rdwrwritnull���     ****
�	 .rdwrclosnull���     ****� 0 err_msg  � ���
� 
errn� 0 err_num  �  
� 
errn� 9��el E�O ��jl O����� O�j 	W X 
 �j 	O)�l�ascr  ��ޭ