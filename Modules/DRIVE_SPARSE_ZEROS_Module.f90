! ##################################################################################################################################

      MODULE DRIVE_SPARSE_ZEROS_Module
 
! Arrays for DRIVE_PARTITION program

      USE PENTIUM_II_KIND, ONLY       :  LONG, DOUBLE

      IMPLICIT NONE
   
      SAVE

      INTEGER(LONG), ALLOCATABLE      :: I_A(:), I_An(:)
      INTEGER(LONG), ALLOCATABLE      :: J_A(:), J_An(:)

      REAL(DOUBLE) , ALLOCATABLE      :: A(:), An(:)
      REAL(DOUBLE) , ALLOCATABLE      :: A_FULL(:,:), An_FULL(:,:)

      END MODULE DRIVE_SPARSE_ZEROS_Module
