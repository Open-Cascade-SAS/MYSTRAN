! ##################################################################################################################################

      MODULE DRIVE_MATMULT_SFF_Module
 
! Arrays for DRIVE_MATMULT_FULL_SFF program

      USE PENTIUM_II_KIND, ONLY       :  BYTE, LONG, DOUBLE

      IMPLICIT NONE
   
      SAVE

      INTEGER(LONG), ALLOCATABLE      :: I_A(:)
      INTEGER(LONG), ALLOCATABLE      :: J_A(:)
  
      REAL(DOUBLE) , ALLOCATABLE      :: A(:)
      REAL(DOUBLE) , ALLOCATABLE      :: B(:,:)
      REAL(DOUBLE) , ALLOCATABLE      :: C(:,:)
      REAL(DOUBLE) , ALLOCATABLE      :: A_FULL(:,:)
  
      END MODULE DRIVE_MATMULT_SFF_Module
