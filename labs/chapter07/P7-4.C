char a[5]='Basic';
char b[5]='MinIX';

main()
  {
   int i;
   i=0;
   do
   {
   a[i]=a[i]&0xDF;
   b[i]=b[i]|0x20;
   i++;
   }
   while(i<5)
  }
