FasdUAS 1.101.10   ��   ��    k             l      ��  ��   

	Vormplus Webtools 1.0
	---------------------------------------------------------------------
	A TextWrangler AppleScript library for editing XHTML and CSS

	Website: http://www.vormplus.be
	Contact: info@vormplus.be

	Copyright 2006 - 2007 Jan Vantomme

	Licensed under the Apache License, Version 2.0 (the "License");
	you may not use this file except in compliance with the License.
	You may obtain a copy of the License at

		http://www.apache.org/licenses/LICENSE-2.0

	Unless required by applicable law or agreed to in writing, software
	distributed under the License is distributed on an "AS IS" BASIS,
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
	See the License for the specific language governing permissions and
	limitations under the License.

     � 	 	( 
 
 	 V o r m p l u s   W e b t o o l s   1 . 0 
 	 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
 	 A   T e x t W r a n g l e r   A p p l e S c r i p t   l i b r a r y   f o r   e d i t i n g   X H T M L   a n d   C S S 
 
 	 W e b s i t e :   h t t p : / / w w w . v o r m p l u s . b e 
 	 C o n t a c t :   i n f o @ v o r m p l u s . b e 
 
 	 C o p y r i g h t   2 0 0 6   -   2 0 0 7   J a n   V a n t o m m e 
 
 	 L i c e n s e d   u n d e r   t h e   A p a c h e   L i c e n s e ,   V e r s i o n   2 . 0   ( t h e   " L i c e n s e " ) ; 
 	 y o u   m a y   n o t   u s e   t h i s   f i l e   e x c e p t   i n   c o m p l i a n c e   w i t h   t h e   L i c e n s e . 
 	 Y o u   m a y   o b t a i n   a   c o p y   o f   t h e   L i c e n s e   a t 
 
 	 	 h t t p : / / w w w . a p a c h e . o r g / l i c e n s e s / L I C E N S E - 2 . 0 
 
 	 U n l e s s   r e q u i r e d   b y   a p p l i c a b l e   l a w   o r   a g r e e d   t o   i n   w r i t i n g ,   s o f t w a r e 
 	 d i s t r i b u t e d   u n d e r   t h e   L i c e n s e   i s   d i s t r i b u t e d   o n   a n   " A S   I S "   B A S I S , 
 	 W I T H O U T   W A R R A N T I E S   O R   C O N D I T I O N S   O F   A N Y   K I N D ,   e i t h e r   e x p r e s s   o r   i m p l i e d . 
 	 S e e   t h e   L i c e n s e   f o r   t h e   s p e c i f i c   l a n g u a g e   g o v e r n i n g   p e r m i s s i o n s   a n d 
 	 l i m i t a t i o n s   u n d e r   t h e   L i c e n s e . 
 
   
  
 l     ��������  ��  ��     ��  l    } ����  O     }    k    |       l   ��������  ��  ��        r    ?    b    =    b    ;    b    9    b    7    b    5     b    3 ! " ! b    1 # $ # b    / % & % b    - ' ( ' b    + ) * ) b    ) + , + b    ' - . - b    % / 0 / b    # 1 2 1 b    ! 3 4 3 b     5 6 5 b     7 8 7 b     9 : 9 b     ; < ; b     = > = b     ? @ ? b     A B A b     C D C b     E F E b     G H G b     I J I b    	 K L K b     M N M m     O O � P P � < ! D O C T Y P E   h t m l   P U B L I C   " - / / W 3 C / / D T D   X H T M L   1 . 0   S t r i c t / / E N "   " h t t p : / / w w w . w 3 . o r g / T R / x h t m l 1 / D T D / x h t m l 1 - s t r i c t . d t d " > N o    ��
�� 
ret  L m     Q Q � R R V < h t m l   x m l n s = " h t t p : / / w w w . w 3 . o r g / 1 9 9 9 / x h t m l " > J o   	 
��
�� 
ret  H m     S S � T T  < h e a d > F o    ��
�� 
ret  D 1    ��
�� 
tab  B m     U U � V V � < m e t a   h t t p - e q u i v = " c o n t e n t - t y p e "   c o n t e n t = " t e x t / h t m l ;   c h a r s e t = u t f - 8 "   / > @ o    ��
�� 
ret  > 1    ��
�� 
tab  < m     W W � X X D < m e t a   n a m e = " l a n g u a g e "   c o n t e n t = " " / > : o    ��
�� 
ret  8 1    ��
�� 
tab  6 m     Y Y � Z Z L < m e t a   n a m e = " d e s c r i p t i o n "   c o n t e n t = " "   / > 4 o     ��
�� 
ret  2 1   ! "��
�� 
tab  0 m   # $ [ [ � \ \ F < m e t a   n a m e = " k e y w o r d s "   c o n t e n t = " "   / > . o   % &��
�� 
ret  , 1   ' (��
�� 
tab  * m   ) * ] ] � ^ ^ H < t i t l e > X H T M L   S t r i c t   D o c u m e n t < / t i t l e > ( o   + ,��
�� 
ret  & m   - . _ _ � ` `  < / h e a d > $ o   / 0��
�� 
ret  " m   1 2 a a � b b  < b o d y >   o   3 4��
�� 
ret   o   5 6��
�� 
ret   m   7 8 c c � d d  < / b o d y >  o   9 :��
�� 
ret   m   ; < e e � f f  < / h t m l >  o      ���� 0 htmldoc     g h g l  @ @��������  ��  ��   h  i j i I  @ d���� k
�� .corecrel****      � null��   k �� l m
�� 
kocl l m   D G��
�� 
TxtD m �� n��
�� 
prdt n K   J ^ o o �� p q
�� 
ptxe p m   M P r r � s s 
 U T F - 8 q �� t u
�� 
pcnt t o   S T���� 0 htmldoc   u �� v��
�� 
pnam v m   W Z w w � x x  i n d e x . h t m l��  ��   j  y z y l  e e��������  ��  ��   z  { | { I  e z�� }��
�� .miscslctnull��� ��� obj  } n   e v ~  ~ n   k v � � � 8   r v��
�� 
cins � 4   k r�� �
�� 
clin � m   n q����   4   e k�� �
�� 
TxtD � m   i j���� ��   |  ��� � l  { {��������  ��  ��  ��    m      � ��                                                                                  !Rch  alis    d  Macintosh HD               ��\mH+     qTextWrangler.app                                                tV��Qs        ����  	                Applications    �٢�      �QW�       q  *Macintosh HD:Applications:TextWrangler.app  "  T e x t W r a n g l e r . a p p    M a c i n t o s h   H D  Applications/TextWrangler.app   / ��  ��  ��  ��       �� � � ���   � ����
�� .aevtoappnull  �   � ****�� 0 htmldoc   � �� ����� � ���
�� .aevtoappnull  �   � **** � k     } � �  ����  ��  ��   �   �  � O�� Q S�� U W Y [ ] _ a c e���������� r���� w��������������
�� 
ret 
�� 
tab �� 0 htmldoc  
�� 
kocl
�� 
TxtD
�� 
prdt
�� 
ptxe
�� 
pcnt
�� 
pnam�� �� 
�� .corecrel****      � null
�� 
clin�� 
�� 
cins
�� .miscslctnull��� ��� obj �� ~� z��%�%�%�%�%�%�%�%�%�%�%�%�%�%�%�%�%�%�%�%�%�%�%�%�%�%�%�%E�O*a a a a a a �a a a a  O*a k/a a /a 3j OPU � � � �< < ! D O C T Y P E   h t m l   P U B L I C   " - / / W 3 C / / D T D   X H T M L   1 . 0   S t r i c t / / E N "   " h t t p : / / w w w . w 3 . o r g / T R / x h t m l 1 / D T D / x h t m l 1 - s t r i c t . d t d " >  < h t m l   x m l n s = " h t t p : / / w w w . w 3 . o r g / 1 9 9 9 / x h t m l " >  < h e a d >  	 < m e t a   h t t p - e q u i v = " c o n t e n t - t y p e "   c o n t e n t = " t e x t / h t m l ;   c h a r s e t = u t f - 8 "   / >  	 < m e t a   n a m e = " l a n g u a g e "   c o n t e n t = " " / >  	 < m e t a   n a m e = " d e s c r i p t i o n "   c o n t e n t = " "   / >  	 < m e t a   n a m e = " k e y w o r d s "   c o n t e n t = " "   / >  	 < t i t l e > X H T M L   S t r i c t   D o c u m e n t < / t i t l e >  < / h e a d >  < b o d y >   < / b o d y >  < / h t m l >ascr  ��ޭ