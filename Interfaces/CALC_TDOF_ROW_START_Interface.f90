! ###############################################################################################################################
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

   MODULE CALC_TDOF_ROW_START_Interface

   INTERFACE

      SUBROUTINE CALC_TDOF_ROW_START ( PRTDEB )

 
      USE PENTIUM_II_KIND, ONLY       :  LONG
      USE SCONTR, ONLY                :  BLNK_SUB_NAM, NGRID
      USE IOUNT1, ONLY                :  ERR, F04, F06, WRT_LOG
      USE TIMDAT, ONLY                :  TSEC
      USE DOF_TABLES, ONLY            :  TDOF_ROW_START
      USE DEBUG_PARAMETERS, ONLY      :  DEBUG
      USE MODEL_STUF, ONLY            :  GRID_ID
      USE SUBR_BEGEND_LEVELS, ONLY    :  CALC_TDOF_ROW_START_BEGEND

      IMPLICIT NONE

      CHARACTER(LEN=*), INTENT(IN)    :: PRTDEB            ! If 'Y' then print debug info if DEBUG(183) also > 0

      INTEGER(LONG), PARAMETER        :: SUBR_BEGEND = CALC_TDOF_ROW_START_BEGEND

      END SUBROUTINE CALC_TDOF_ROW_START

   END INTERFACE

   END MODULE CALC_TDOF_ROW_START_Interface

