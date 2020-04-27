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

   MODULE REDUCE_KGGD_TO_KNND_Interface

   INTERFACE

      SUBROUTINE REDUCE_KGGD_TO_KNND ( PART_VEC_G_NM )

 
      USE PENTIUM_II_KIND, ONLY       :  BYTE, LONG, DOUBLE
      USE IOUNT1, ONLY                :  ERR, F04, F06, L2J, LINK2J, L2J_MSG, SC1, WRT_ERR, WRT_LOG
      USE SCONTR, ONLY                :  BLNK_SUB_NAM, FATAL_ERR, NDOFG, NDOFN, NDOFM, NTERM_HMN, NTERM_KGGD, NTERM_KNND,          &
                                         NTERM_KNMD, NTERM_KMMD, NTERM_GMN
      USE PARAMS, ONLY                :  EPSIL, SPARSTOR
      USE TIMDAT, ONLY                :  TSEC
      USE SUBR_BEGEND_LEVELS, ONLY    :  REDUCE_KGGD_TO_KNND_BEGEND
      USE CONSTANTS_1, ONLY           :  ONE 
      USE SPARSE_MATRICES, ONLY       :  I_HMN, J_HMN, HMN, I_KGGD, J_KGGD, KGGD, I_KNND, J_KNND, KNND, I_KNMD, J_KNMD, KNMD,      &
                                         I_KMMD, J_KMMD, KMMD, I_KMND, J_KMND, KMND, I_GMN, J_GMN, GMN,  I_GMNt, J_GMNt, GMNt
      USE SPARSE_MATRICES, ONLY       :  SYM_GMN, SYM_HMN, SYM_KGGD, SYM_KNND, SYM_KNMD, SYM_KMMD, SYM_KMND
      USE SCRATCH_MATRICES

      IMPLICIT NONE

      INTEGER(LONG), INTENT(IN)       :: PART_VEC_G_NM(NDOFG)! Partitioning vector (G set into N and M sets) 
      INTEGER(LONG), PARAMETER        :: NUM1        = 1     ! Used in subr's that partition matrices
      INTEGER(LONG), PARAMETER        :: NUM2        = 2     ! Used in subr's that partition matrices
      INTEGER(LONG), PARAMETER        :: SUBR_BEGEND = REDUCE_KGGD_TO_KNND_BEGEND

      END SUBROUTINE REDUCE_KGGD_TO_KNND

   END INTERFACE

   END MODULE REDUCE_KGGD_TO_KNND_Interface

