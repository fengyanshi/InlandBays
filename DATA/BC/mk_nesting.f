         parameter (Ntotal=10000,nsta_tot=1000)
         parameter (Nb=2000)
         real west_z(nsta_tot,ntotal),west_u(nsta_tot,ntotal),
     &       time(ntotal),
     &        west_v(nsta_tot,ntotal),
     &        east_z(nsta_tot,ntotal),
     &        east_u(nsta_tot,ntotal),east_v(nsta_tot,ntotal),
     &        south_z(nsta_tot,ntotal),south_u(nsta_tot,ntotal),
     &        south_v(nsta_tot,ntotal),
     &        north_z(nsta_tot,ntotal),north_u(nsta_tot,ntotal),
     &        north_v(nsta_tot,ntotal)

         real U_COUPLING_WEST(Nb,Ntotal),
     &       V_COUPLING_WEST(Nb,Ntotal),
     &       Z_COUPLING_WEST(Nb,Ntotal),
     &       U_COUPLING_EAST(Nb,Ntotal),
     &       V_COUPLING_EAST(Nb,Ntotal),
     &       Z_COUPLING_EAST(Nb,Ntotal),
     &       U_COUPLING_SOUTH(Nb,Ntotal),
     &       V_COUPLING_SOUTH(Nb,Ntotal),
     &       Z_COUPLING_SOUTH(Nb,Ntotal),
     &       U_COUPLING_NORTH(Nb,Ntotal),
     &       V_COUPLING_NORTH(Nb,Ntotal),
     &       Z_COUPLING_NORTH(Nb,Ntotal)
         integer J_START_SOUTH,J_START_NORTH,J_START_EAST
     &       J_START_WEST

         CHARACTER(LEN=80) FDIR
         CHARACTER(LEN=4) FILE_NAME
         integer icount

         icount=0

! input parameters

         nsta=1
         nwest=0
         nsouth=0
         neast=90
         nnorth=0

    
         time_cut=0.0
!         time_cut=60*60*10     
         iscale = 1

        J_START_WEST = 1
        J_START_EAST = 1
        J_START_SOUTH = 1
        J_START_NORTH = 1

! end input paramters

         Nsm_west=(nwest-1)*iscale +1
         Nsm_south=(nsouth-1)*iscale +1
         Nsm_east=(neast-1)*iscale +1
         Nsm_north=(nnorth-1)*iscale +1

         print*,'Nsm_west',Nsm_west,'Nsm_east',Nsm_east
         print*,'Nsm_north',Nsm_north,'Nsm_south',Nsm_south


         fdir='../grid_A/'

!  --------------  construct data
       Ndata=2880

!  read data

!  east
        OPEN(1,file='lewes_sandy.txt')
        DO K=1,Ndata
          READ(1,*) TIME(K), east_z(1,k)
          TIME(K)=TIME(K)*24.0*3600.0
        ENDDO
        CLOSE(1)


        DO K=1,Ndata

       IF(Neast>0)THEN 
         DO I=1,Neast
             Z_COUPLING_east(I,K)=east_z(1,K)
             U_COUPLING_east(I,K)=0.0
             V_COUPLING_east(I,K)=0.0
         ENDDO
       ENDIF

        ENDDO

        OPEN(1,FILE='coupling_sandy.txt')
         WRITE(1,*) 'coupling data'
         WRITE(1,*) 'boundary info: num of points, start point'
         WRITE(1,*) 'EAST'
         WRITE(1,*) Nsm_east-J_TRIM_EAST-J_START_EAST+1, J_START_EAST
         WRITE(1,*) 'WEST'
         WRITE(1,*) Nsm_west-J_TRIM_WEST-J_START_WEST+1, J_START_WEST
         WRITE(1,*) 'SOUTH'
         WRITE(1,*) Nsm_south-J_TRIM_SOUTH-J_START_SOUTH+1, 
     &              J_START_SOUTH
         WRITE(1,*) 'NORTH'
         WRITE(1,*) Nsm_north-J_TRIM_NORTH-J_START_NORTH+1, 
     &              J_START_NORTH


119      FORMAT(5E16.6)

         WRITE(1,*) 'TIME SERIES'
         DO K=Kstart,Ndata
           WRITE(1,*)TIME(K)
! east
           WRITE(1,*)'EAST SIDE'
          IF(Neast>0)THEN
             WRITE(1,119)(U_COUPLING_east(I,K),I=J_START_EAST,
     &         Nsm_east-J_TRIM_EAST)
             WRITE(1,119)(V_COUPLING_east(I,K),I=J_START_EAST,
     &         Nsm_east-J_TRIM_EAST)
             WRITE(1,119)(Z_COUPLING_east(I,K),I=J_START_EAST,
     &         Nsm_east-J_TRIM_EAST)
          ENDIF
! west
           WRITE(1,*)'WEST SIDE'
          IF(NWEST>0)THEN
             WRITE(1,119)(U_COUPLING_WEST(I,K),I=J_START_WEST,
     &         Nsm_WEST-J_TRIM_WEST)
             WRITE(1,119)(V_COUPLING_WEST(I,K),I=J_START_WEST,
     &         Nsm_WEST-J_TRIM_WEST)
             WRITE(1,119)(Z_COUPLING_WEST(I,K),I=J_START_WEST,
     &         Nsm_WEST-J_TRIM_WEST)
          ENDIF

! south
           WRITE(1,*)'SOUTH SIDE'
          IF(NSOUTH>0)THEN
             WRITE(1,119)(U_COUPLING_SOUTH(I,K),I=J_START_SOUTH,
     &         Nsm_SOUTH-J_TRIM_SOUTH)
             WRITE(1,119)(V_COUPLING_SOUTH(I,K),I=J_START_SOUTH,
     &         Nsm_SOUTH-J_TRIM_SOUTH)
             WRITE(1,119)(Z_COUPLING_SOUTH(I,K),I=J_START_SOUTH,
     &         Nsm_SOUTH-J_TRIM_SOUTH)
          ENDIF

! north
           WRITE(1,*)'NORTH SIDE'
          IF(NNORTH>0)THEN
             WRITE(1,119)(U_COUPLING_NORTH(I,K),I=J_START_NORTH,
     &         Nsm_NORTH-J_TRIM_NORTH)
             WRITE(1,119)(V_COUPLING_NORTH(I,K),I=J_START_NORTH,
     &         Nsm_NORTH-J_TRIM_NORTH)
             WRITE(1,119)(Z_COUPLING_NORTH(I,K),I=J_START_NORTH,
     &         Nsm_NORTH-J_TRIM_NORTH)
          ENDIF

         ENDDO ! end time

100      format(999E16.5)

         CLOSE(1)

         end









