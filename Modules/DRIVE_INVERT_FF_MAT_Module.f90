! ##################################################################################################################################

      MODULE DRIVE_INVERT_FF_MAT_Module
 
! Arrays for DRIVE_INVERT_FF_MAT program

      USE PENTIUM_II_KIND, ONLY       :  BYTE, LONG, DOUBLE

      IMPLICIT NONE
   
      SAVE

      REAL(DOUBLE) , ALLOCATABLE      :: A_FULL(:,:)
      REAL(DOUBLE) , ALLOCATABLE      :: AI_FULL(:,:)
      REAL(DOUBLE) , ALLOCATABLE      :: AAI_FULL(:,:)
  
      END MODULE DRIVE_INVERT_FF_MAT_Module
