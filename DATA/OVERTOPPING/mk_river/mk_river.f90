       PROGRAM MK_RIVER
       CHARACTER(LEN=80) :: RIVER_FILE
       CHARACTER (LEN=1),DIMENSION(:), ALLOCATABLE :: RIVER_ORIENTATION
    
! the program was made for river flux file generation. 
! now it is modified for overtopping flux file.
! no change to variable name
! 02/22/2017

	INTEGER :: NumRiverPoint,NumTime
       INTEGER ::  I,J,K

       REAL,DIMENSION(:,:),ALLOCATABLE :: &
                  RiverU,RiverAngle
       REAL :: RiverStartTime,tmpI,tmpJ
       REAL,DIMENSION(:),ALLOCATABLE :: TIME
       INTEGER,DIMENSION(:),ALLOCATABLE :: I_river_bd,J_river_bd


       NumTime=72
       NumRiverPoint = 10
       ALLOCATE(RiverU(NumRiverPoint,NumTime), &
                RiverAngle(NumRiverPoint,NumTime), &
                TIME(NumTime), &
                I_river_bd(NumRiverPoint), &
                J_river_bd(NumRiverPoint), &
                RIVER_ORIENTATION(NumRiverPoint) &
                           )

       RIVER_FILE='otflux_bipeak.txt'
      RiverStartTime= 451800 !432000.0+1800.0+5*3600.0 ! 10/23/2012 to 10/28/2012 tingting's data starts from 1800s
      ! RiverStartTime = 3600.0+6*3600;
	   
	   RiverU=0.0 ! pre
	   open(10,file='flux_bipeak.txt')
		 do j=1,numriverpoint
           read(10,*)(RiverU(j,i),i=1,numtime) ! matrix 21*72
         enddo
       close(10)
	   
       DO I=1,NumTime
         Time(I)=RiverStartTime+(I-1)*3600.0 ! one hour interval
         DO J=1,NumRiverPoint
          RiverAngle(J,I)=186.3813 !6.3813+180
        !  RiverU(J,I)= flux_intp(J,I)
         ENDDO
       ENDDO
       

       open(11,file='flux_grid_index_bipeak.txt') ! format: x_index, y_index
       DO I=1,NumRiverPoint
       ! OLD CODE
       !  I_river_bd(I)=72
       !  J_river_bd(I)=57+I

       ! NEW CODE
         read(11,*) tmpI,tmpJ  ! format: x_index, y_index
         I_river_bd(I)=int(tmpI)
         J_river_bd(I)=int(tmpJ)
       !---------------------------------------------
         RIVER_ORIENTATION(I)='E'
       ENDDO

       OPEN(2,FILE=TRIM(RIVER_FILE))
         WRITE(2,*)'river flux boundary condition'

         WRITE(2,'(I8,I8,A30)') NumTime,NumRiverPoint,&
                              '! NumTimeData, NumFluxPoint'


         DO J=1,NumRiverPoint
           WRITE(2,'(2I4,  A3, A30)') I_river_bd(J),J_river_bd(J),RIVER_ORIENTATION(J), &
                                          '     !I, J, River_Orientation'
         DO I = 1,NumTime
           WRITE(2,'(F12.3,2F12.3)') Time(I), RiverU(J,I),RiverAngle(J,I)
         ENDDO
         ENDDO
         WRITE(2,*) 'end of file'

       CLOSE(2)


       END
