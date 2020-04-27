! ##################################################################################################################################

      MODULE DRIVE_MATTRNSP_SS_Module

! Arrays for DRIVE_MATTRNSP_SS program

      USE PENTIUM_II_KIND, ONLY       :  BYTE, LONG, DOUBLE

      IMPLICIT NONE

      SAVE

      INTEGER(LONG), ALLOCATABLE      :: I_A(:)
      INTEGER(LONG), ALLOCATABLE      :: J_A(:)
      INTEGER(LONG), ALLOCATABLE      :: I_AT(:)
      INTEGER(LONG), ALLOCATABLE      :: J_AT(:)

      REAL(DOUBLE) , ALLOCATABLE      :: A(:)
      REAL(DOUBLE) , ALLOCATABLE      :: AT(:)

      REAL(DOUBLE) , ALLOCATABLE      :: A_FULL(:,:)
      REAL(DOUBLE) , ALLOCATABLE      :: AT_FULL(:,:)

      END MODULE DRIVE_MATTRNSP_SS_Module
