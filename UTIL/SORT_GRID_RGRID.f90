! ##################################################################################################################################
! Begin MIT license text.                                                                                    
! _______________________________________________________________________________________________________
                                                                                                         
! Copyright 2019 Dr William R Case, Jr (dbcase29@gmail.com)                                              
                                                                                                         
! Permission is hereby granted, free of charge, to any person obtaining a copy of this software and      
! associated documentation files (the "Software"), to deal in the Software without restriction, including
! without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
! copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to   
! the following conditions:                                                                              
                                                                                                         
! The above copyright notice and this permission notice shall be included in all copies or substantial   
! portions of the Software and documentation.                                                                              
                                                                                                         
! THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS                                
! OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,                            
! FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE                            
! AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER                                 
! LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,                          
! OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN                              
! THE SOFTWARE.                                                                                          
! _______________________________________________________________________________________________________
                                                                                                        
! End MIT license text.                                                                                      
 
      SUBROUTINE SORT_GRID_RGRID ( CALLING_SUBR, MESSAG, NSIZE, IARRAY, RARRAY )
 
! Performs shell sort on integer IARRAY (GRID) and real RARRAY (RGRID) to put them into an order where the GRID ID
! (in column 1 of IARRAY) is in numerically increasing order
 
      USE PENTIUM_II_KIND, ONLY       :  BYTE, LONG, DOUBLE
      USE IOUNT1, ONLY                :  WRT_ERR, WRT_LOG, ERR, F04, F06
      USE SCONTR, ONLY                :  BLNK_SUB_NAM, FATAL_ERR, MGRID, MRGRID
      USE PARAMS, ONLY                :  SORT_MAX
      USE TIMDAT, ONLY                :  TSEC
      USE SUBR_BEGEND_LEVELS, ONLY    :  SORT_GRID_RGRID_BEGEND
 
      USE SORT_GRID_RGRID_USE_IFs

      IMPLICIT NONE
 
      CHARACTER(LEN=LEN(BLNK_SUB_NAM)):: SUBR_NAME = 'SORT_GRID_RGRID'
      CHARACTER(LEN=*), INTENT(IN)    :: CALLING_SUBR        ! Subr that called this subr
      CHARACTER(LEN=*), INTENT(IN)    :: MESSAG              ! Message to be written out if this subr fails to sort
      CHARACTER( 3*BYTE)              :: SORTED              ! = 'YES' if array is sorted

      INTEGER(LONG), INTENT(IN)       :: NSIZE               ! No. rows in arrays IARRAY, RARRAY
      INTEGER(LONG), INTENT(INOUT)    :: IARRAY(NSIZE,MGRID) ! Array GRID
      INTEGER(LONG)                   :: I,K,M               ! DO loop indices
      INTEGER(LONG)                   :: IDUM1               ! Dummy values in IARRAY used when switching IARRAY rows during sort 
      INTEGER(LONG)                   :: IFLIP               ! Indicates whether two values have been switched in sort order.
      INTEGER(LONG)                   :: JCT                 ! Shell sort parameter returned from subroutine SORTLEN.
      INTEGER(LONG)                   :: MAXM                ! NSIZE - SORTPK
      INTEGER(LONG)                   :: N                   ! An array index
      INTEGER(LONG)                   :: SORTPK              ! Intermediate variable used in setting a DO loop range.
      INTEGER(LONG)                   :: SORT_NUM            ! How many times the sort has to be performed in order for the data
!                                                              to be in sort order. SORT_MAX is max value
      INTEGER(LONG), PARAMETER        :: SUBR_BEGEND = SORT_GRID_RGRID_BEGEND
 
      REAL(DOUBLE),  INTENT(INOUT)    :: RARRAY(NSIZE,MRGRID)! Array RGRID 
      REAL(DOUBLE)                    :: RDUM1               ! Dummy values in RARRAY used when switching RARRAY rows during sort
 
! **********************************************************************************************************************************
      IF (WRT_LOG >= SUBR_BEGEND) THEN
         CALL OURTIM
         WRITE(F04,9001) SUBR_NAME,TSEC
 9001    FORMAT(1X,A,' BEGN ',F10.3)
      ENDIF

! **********************************************************************************************************************************
! Call SORTLEN to calculate the shell sort parameter JCT
 
      SORT_NUM = 1

      CALL SORTLEN ( NSIZE, JCT )

outer:DO                                                      ! Run sort until array is sorted or SORT_MAX is exceeded

         DO K = JCT,1,-1                                      ! Do the sort
            SORTPK = 2**K - 1
            MAXM  = NSIZE - SORTPK
            IFLIP = 0
            DO
               DO M = 1,MAXM
                  N = M + SORTPK
                  IF (IARRAY(M,1) > IARRAY(N,1)) THEN
                     DO I=1,MGRID
                        IDUM1       = IARRAY(M,I)
                        IARRAY(M,I) = IARRAY(N,I)
                        IARRAY(N,I) = IDUM1
                     ENDDO 
                     DO I=1,MRGRID
                        RDUM1       = RARRAY(M,I)
                        RARRAY(M,I) = RARRAY(N,I)
                        RARRAY(N,I) = RDUM1
                     ENDDO 
                     IFLIP = 1
                  ENDIF                     
               ENDDO
               IF (IFLIP == 1) THEN
                  IFLIP = 0
                  CYCLE
               ELSE
                  EXIT
               ENDIF
            ENDDO 
         ENDDO

         SORTED = 'YES'                                    ! Make sure array is sorted
chk_sort:DO I=1,NSIZE-1
            IF (IARRAY(I,1) > IARRAY(I+1,1)) THEN
            SORTED = 'NO '
            EXIT chk_sort
            ENDIF
         ENDDO chk_sort

         IF (SORTED == 'YES') THEN                         ! If array is sorted, exit outer loop
            EXIT outer
         ELSE                                              ! If array is not sorted, sort again if SORT_MAX num times not exceeded
            SORT_NUM = SORT_NUM + 1
            IF (SORT_NUM <= SORT_MAX) THEN
               CYCLE outer
            ELSE
               WRITE(ERR, 914) SUBR_NAME, CALLING_SUBR, SORT_MAX, MESSAG
               WRITE(F06, 914) SUBR_NAME, CALLING_SUBR, SORT_MAX, MESSAG
               FATAL_ERR = FATAL_ERR + 1
               CALL OUTA_HERE ( 'Y' )                      ! Can't get array sorted after trying SORT_MAX times, so quit
            ENDIF
         ENDIF

      ENDDO outer

! **********************************************************************************************************************************
      IF (WRT_LOG >= SUBR_BEGEND) THEN
         CALL OURTIM
         WRITE(F04,9002) SUBR_NAME,TSEC
 9002    FORMAT(1X,A,' END  ',F10.3)
      ENDIF

      RETURN

! **********************************************************************************************************************************
  914 FORMAT(' *ERROR   914: SUBROUTINE ',A,', CALLED BY SUBR ',A                                                                  &
                    ,/,14X,' HAS MADE ',I8,' UNSUCCESSFUL ATTEMPTS TO SORT ARRAY(S) ',A                                            &
                    ,/,14X,' THE MAX NUMBER OF SORT ATTEMPTS CAN BE INCREASED WITH BULK DATA PARAM SORT_MAX') 

! **********************************************************************************************************************************

      END SUBROUTINE SORT_GRID_RGRID
