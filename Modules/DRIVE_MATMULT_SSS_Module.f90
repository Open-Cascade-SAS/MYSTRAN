! ##################################################################################################################################

      MODULE DRIVE_MATMULT_SSS_Module
 
! Arrays for DRIVE_MATMULT_FULL_SSS program

      USE PENTIUM_II_KIND, ONLY       :  BYTE, LONG, DOUBLE

      IMPLICIT NONE
   
      SAVE

      INTEGER(LONG), ALLOCATABLE      :: I_A(:)
      INTEGER(LONG), ALLOCATABLE      :: J_A(:)

      INTEGER(LONG), ALLOCATABLE      :: I_B(:)
      INTEGER(LONG), ALLOCATABLE      :: J_B(:)

      INTEGER(LONG), ALLOCATABLE      :: I_B_CCS(:)
      INTEGER(LONG), ALLOCATABLE      :: J_B_CCS(:)

      INTEGER(LONG), ALLOCATABLE      :: I_C(:)
      INTEGER(LONG), ALLOCATABLE      :: J_C(:)
  
      REAL(DOUBLE) , ALLOCATABLE      :: A(:)
      REAL(DOUBLE) , ALLOCATABLE      :: B(:)
      REAL(DOUBLE) , ALLOCATABLE      :: B_CCS(:)
      REAL(DOUBLE) , ALLOCATABLE      :: C(:)
      REAL(DOUBLE) , ALLOCATABLE      :: A_FULL(:,:)
      REAL(DOUBLE) , ALLOCATABLE      :: B_FULL(:,:)
      REAL(DOUBLE) , ALLOCATABLE      :: C_FULL(:,:)
  

      END MODULE DRIVE_MATMULT_SSS_Module
