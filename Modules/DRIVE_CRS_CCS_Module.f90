! ##################################################################################################################################

      MODULE DRIVE_CRS_CCS_Module
 
! Arrays for DRIVE_CRS_CCS program

      USE PENTIUM_II_KIND, ONLY       :  BYTE, LONG, DOUBLE

      IMPLICIT NONE
   
      SAVE

      INTEGER(LONG), ALLOCATABLE      :: I_A(:)
      INTEGER(LONG), ALLOCATABLE      :: J_A(:)
      INTEGER(LONG), ALLOCATABLE      :: I_B(:)
      INTEGER(LONG), ALLOCATABLE      :: J_B(:)
  
      REAL(DOUBLE) , ALLOCATABLE      :: A(:)
      REAL(DOUBLE) , ALLOCATABLE      :: B(:)
  
      REAL(DOUBLE) , ALLOCATABLE      :: A_FULL(:,:)
      REAL(DOUBLE) , ALLOCATABLE      :: B_FULL(:,:)

      END MODULE DRIVE_CRS_CCS_Module
