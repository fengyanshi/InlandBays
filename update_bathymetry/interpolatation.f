         parameter(m=4501,n=4321,m1=198,n1=141)
         real data(m,n),x(m1,n1),y(m1,n1)
         real dep(m1,n1)
         integer ix,iy
         character*80 fdir
         character*80 dep_name

         
         fdir='/Volumes/2TB_element/Seagrant_2016_nobu/DEM_larger/'
         dep_name='inland_7520_7455_3824_3848.txt'

         open(1,file=trim(fdir)//trim(dep_name))

         do j=1,n
          read(1,*)(data(i,j),i=1,m)
         enddo
         close(1)

         open(1,file='x_add_bethany.txt')
           do i=1,m1
            read(1,*)(x(i,j),j=1,n1)
           enddo
         close(1)
         open(1,file='y_add_bethany.txt')
           do i=1,m1
            read(1,*)(y(i,j),j=1,n1)
           enddo
         close(1)   

         do j=1,n1
         do i=1,m1
           y(i,j)=y(i,j)+1450.0
         enddo
         enddo      

         open(2,file='xtmp.txt')
          do j=1,n1
           write(2,100)(x(i,j),i=1,m1)
          enddo
         close(2)
         open(2,file='ytmp.txt')
          do j=1,n1
           write(2,100)(y(i,j),i=1,m1)
          enddo
         close(2)
 

         do j=1,n1-1
           do i=1,m1-1
             ix=x(i,j)
             iy=y(i,j)
             rx=x(i,j)-ix
             ry=y(i,j)-iy
             if(ix.lt.1.or.ix+1.gt.m.or.iy.lt.1.or.iy+1.gt.n)then
               print*,i,j,ix,iy
               dep(i,j)=9999.0
             else
             dep(i,j)=((1.0-rx)*data(ix,iy)+rx*data(ix+1,iy))*(1.0-ry)+
     *                 ((1.0-rx)*data(ix,iy+1)+rx*data(ix+1,iy+1))*ry
             endif
           enddo
!           print*,'j= /77',j
         enddo 


         open(2,file='dep_196x140.txt')
         do j=1,n1-1
           write(2,100)(-dep(i,j),i=1,m1-2)
         enddo
100      format(5000f16.3)

         close(2)
         end
