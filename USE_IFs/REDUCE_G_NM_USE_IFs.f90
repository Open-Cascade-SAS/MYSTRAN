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

      MODULE REDUCE_G_NM_USE_IFs

! USE Interface statements for all subroutines called by SUBROUTINE REDUCE_G_NM

      USE OURTIM_Interface
      USE PARTITION_VEC_Interface
      USE SOLVE_GMN_Interface
      USE DEALLOCATE_SPARSE_MAT_Interface
      USE REDUCE_KGG_TO_KNN_Interface
      USE ALLOCATE_SPARSE_MAT_Interface
      USE REDUCE_MGG_TO_MNN_Interface
      USE REDUCE_PG_TO_PN_Interface
      USE WRITE_SPARSE_CRS_Interface
      USE GET_MATRIX_DIAG_STATS_Interface
      USE ALLOCATE_RBGLOBAL_Interface
      USE TDOF_COL_NUM_Interface
      USE STIFF_MAT_EQUIL_CHK_Interface
      USE GET_GRID_NUM_COMPS_Interface
      USE AUTOSPC_SUMMARY_MSGS_Interface
      USE REDUCE_KGGD_TO_KNND_Interface
      USE OPNERR_Interface
      USE FILERR_Interface
      USE OUTA_HERE_Interface
      USE GET_ARRAY_ROW_NUM_Interface
      USE FILE_CLOSE_Interface
      USE TDOF_PROC_Interface
      USE FILE_OPEN_Interface
      USE WRITE_DOF_TABLES_Interface

      END MODULE REDUCE_G_NM_USE_IFs
