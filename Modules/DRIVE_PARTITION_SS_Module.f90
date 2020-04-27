! ##################################################################################################################################

      MODULE DRIVE_PARTITION_SS_Module
 
! Arrays for DRIVE_PARTITION program

      USE PENTIUM_II_KIND, ONLY       :  BYTE, LONG, DOUBLE

      IMPLICIT NONE
   
      SAVE

      INTEGER(LONG), ALLOCATABLE      :: I_A(:)
      INTEGER(LONG), ALLOCATABLE      :: J_A(:)
      INTEGER(LONG), ALLOCATABLE      :: I_B(:)
      INTEGER(LONG), ALLOCATABLE      :: J_B(:)
      INTEGER(LONG), ALLOCATABLE      :: ROW_PART_VEC(:)
      INTEGER(LONG), ALLOCATABLE      :: COL_PART_VEC(:)
  
      REAL(DOUBLE) , ALLOCATABLE      :: A(:)
      REAL(DOUBLE) , ALLOCATABLE      :: A_FULL(:,:)
      REAL(DOUBLE) , ALLOCATABLE      :: B(:)
      REAL(DOUBLE) , ALLOCATABLE      :: B_FULL(:,:)
  

      END MODULE DRIVE_PARTITION_SS_Module
