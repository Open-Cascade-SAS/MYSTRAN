! ##################################################################################################################################

      MODULE DRIVE_MATADD_SSS_Module
 
! Arrays for DRIVE_MATADD_SSS program

      USE PENTIUM_II_KIND, ONLY       :  BYTE, LONG, DOUBLE

      IMPLICIT NONE
   
      SAVE

      LOGICAL      , ALLOCATABLE      :: LOGICAL_VEC(:)

      INTEGER(LONG), ALLOCATABLE      :: I_A(:)
      INTEGER(LONG), ALLOCATABLE      :: J_A(:)
      INTEGER(LONG), ALLOCATABLE      :: I_B(:)
      INTEGER(LONG), ALLOCATABLE      :: J_B(:)
      INTEGER(LONG), ALLOCATABLE      :: I_C(:)
      INTEGER(LONG), ALLOCATABLE      :: J_C(:)
  
      REAL(DOUBLE) , ALLOCATABLE      :: A(:)
      REAL(DOUBLE) , ALLOCATABLE      :: B(:)
      REAL(DOUBLE) , ALLOCATABLE      :: C(:)
  
      REAL(DOUBLE) , ALLOCATABLE      :: A_FULL(:,:)
      REAL(DOUBLE) , ALLOCATABLE      :: B_FULL(:,:)
      REAL(DOUBLE) , ALLOCATABLE      :: C_FULL(:,:)

      END MODULE DRIVE_MATADD_SSS_Module
