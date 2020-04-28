################################################################################

F77=gfortran
AR=ar
FLAGS+=-O3 -std=legacy -IINCLUDE -Llib -Jobj -L$(CONDA_PREFIX)\Library\lib

################################################################################

ARPACKOBJ+=$(patsubst ARPACK/%.f90,obj/%.o,$(wildcard ARPACK/*.f90))

BANDITOBJ+=$(patsubst BANDIT/%.f90,obj/%.o,$(wildcard BANDIT/*.f90))

EMG1OBJ+=$(patsubst EMG/EMG1/%.f90,obj/%.o,$(wildcard EMG/EMG1/*.f90))
EMG2OBJ+=$(patsubst EMG/EMG2/%.f90,obj/%.o,$(wildcard EMG/EMG2/*.f90))
EMG3OBJ+=$(patsubst EMG/EMG3/%.f90,obj/%.o,$(wildcard EMG/EMG3/*.f90))
EMG4OBJ+=$(patsubst EMG/EMG4/%.f90,obj/%.o,$(wildcard EMG/EMG4/*.f90))
EMG5OBJ+=$(patsubst EMG/EMG5/%.f90,obj/%.o,$(wildcard EMG/EMG5/*.f90))
EMG6OBJ+=$(patsubst EMG/EMG6/%.f90,obj/%.o,$(wildcard EMG/EMG6/*.f90))
EMG7OBJ+=$(patsubst EMG/EMG7/%.f90,obj/%.o,$(wildcard EMG/EMG7/*.f90))
EMG8OBJ+=$(patsubst EMG/EMG8/%.f90,obj/%.o,$(wildcard EMG/EMG8/*.f90))
EMGOBJ+=$(EMG1OBJ) $(EMG2OBJ) $(EMG3OBJ) $(EMG4OBJ) $(EMG5OBJ) $(EMG6OBJ) $(EMG7OBJ) $(EMG8OBJ)

INTERFACESF90+=$(wildcard Interfaces/*.f90)

L1AOBJ+=$(patsubst LK1/L1A/%.f90,obj/%.o,$(wildcard LK1/L1A/*.f90))
L1ABDOBJ+=$(patsubst LK1/L1A-BD/%.f90,obj/%.o,$(wildcard LK1/L1A-BD/*.f90))
L1ACCOBJ+=$(patsubst LK1/L1A-CC/%.f90,obj/%.o,$(wildcard LK1/L1A-CC/*.f90))
L1BOBJ+=$(patsubst LK1/L1B/%.f90,obj/%.o,$(wildcard LK1/L1B/*.f90))
L1COBJ+=$(patsubst LK1/L1C/%.f90,obj/%.o,$(wildcard LK1/L1C/*.f90))
L1DOBJ+=$(patsubst LK1/L1D/%.f90,obj/%.o,$(wildcard LK1/L1D/*.f90))
L1EOBJ+=$(patsubst LK1/L1E/%.f90,obj/%.o,$(wildcard LK1/L1E/*.f90))
L1UOBJ+=$(patsubst LK1/L1U/%.f90,obj/%.o,$(wildcard LK1/L1U/*.f90))
LINK1OBJ+=$(patsubst LK1/LINK1/%.f90,obj/%.o,$(wildcard LK1/LINK1/*.f90))
LK1OBJ+=$(L1AOBJ) $(L1ABDOBJ) $(L1ACCOBJ) $(L1BOBJ) $(L1COBJ) $(L1DOBJ) $(L1EOBJ) $(L1UOBJ) $(LINK1OBJ)
LK2OBJ+=$(patsubst LK2/%.f90,obj/%.o,$(wildcard LK2/*.f90))
LK3OBJ+=$(patsubst LK3/%.f90,obj/%.o,$(wildcard LK3/*.f90))
LK4OBJ+=$(patsubst LK4/%.f90,obj/%.o,$(wildcard LK4/*.f90))
LK5OBJ+=$(patsubst LK5/%.f90,obj/%.o,$(wildcard LK5/*.f90))
LK6OBJ+=$(patsubst LK6/%.f90,obj/%.o,$(wildcard LK6/*.f90))
L91OBJ+=$(patsubst LK9/L91/%.f90,obj/%.o,$(wildcard LK9/L91/*.f90))
L92OBJ+=$(patsubst LK9/L92/%.f90,obj/%.o,$(wildcard LK9/L92/*.f90))
LINK9OBJ+=$(patsubst LK9/LINK9/%.f90,obj/%.o,$(wildcard LK9/LINK9/*.f90))
LK9OBJ+=$(L91OBJ) $(L92OBJ) $(LINK9OBJ)
LKOBJ+=$(LK1OBJ) $(LK2OBJ) $(LK3OBJ) $(LK4OBJ) $(LK5OBJ) $(LK6OBJ) $(LK9OBJ)

MAINOBJ+=$(patsubst MAIN/%.f90,obj/%.o,$(wildcard MAIN/*.f90))

MODUlESROOTF90+=$(wildcard Modules/*.f90)
MODUlESARPACKF90+=$(wildcard Modules/ARPACK/*.f)
MODUlESBANDITF90+=Modules/Bandit/BANDIT_BLOCK_DATA.f90 Modules/Bandit/BANDIT_MODULE.f
MODUlESLAPACKF90+=$(wildcard Modules/LAPACK/*.f)
MODUlESF90+=$(MODUlESROOTF90) $(MODUlESARPACKF90) $(MODUlESBANDITF90) $(MODUlESLAPACKF90)

USEIFSOBJ+=$(patsubst USE_IFs/%.f90,obj/%.o,$(wildcard USE_IFs/*.f90))
UTILOBJ+=$(patsubst UTIL/%.f90,obj/%.o,$(wildcard UTIL/*.f90))

ALLOBJ+=$(ARPACKOBJ) $(BANDITOBJ) $(ENGOBJ) $(INTERFACESOBJ) $(LKOBJ) $(MAINOBJ) $(MODUlESOBJ) $(USEIFSOBJ) $(UTILOBJ)

################################################################################

all:            nastran
nastran:        bin lib obj bin/nastran.exe
arpack:         lib obj lib/libarpack.a
bandit:         lib obj lib/libbandit.a
emg:            lib obj lib/libemg.a
lk:             lib obj lib/liblk.a
useifs:         lib obj lib/libuseifs.a
util:           lib obj lib/libutil.a

lib:
	mkdir -p lib
obj:
	mkdir -p obj
bin:
	mkdir -p bin
clean:
	rm -rf obj lib
	rm -f bin/*.exe

lib/libarpack.a: $(ARPACKOBJ)
	$(AR) cr $@ $^

lib/libbandit.a: $(BANDITOBJ)
	$(AR) cr $@ $^

lib/libemg.a: $(EMGOBJ)
	$(AR) cr $@ $^

lib/liblk.a: $(LKOBJ)
	$(AR) cr $@ $^

lib/libuseifs.a: $(USEIFSOBJ)
	$(AR) cr $@ $^

lib/libutil.a: $(UTILOBJ)
	$(AR) cr $@ $^

lib/libnas.a: $(ARPACKOBJ) $(BANDITOBJ) $(EMGOBJ) $(LKOBJ) $(USEIFSOBJ) $(UTILOBJ)
	$(AR) crT $@ $^

bin/nastran.exe: $(MAINOBJ) lib/libnas.a
	$(F77) $(FLAGS) -static $(MAINOBJ) $(MODUlESF90) $(INTERFACESF90) -lnas -lmkl_rt -o $@

obj/ARPACK_INFO_MSG.o: ARPACK/ARPACK_INFO_MSG.f90 obj/PENTIUM_II_KIND.o obj/SCONTR.o obj/IOUNT1.o obj/PARAMS.o obj/MODEL_STUF.o obj/ARPACK_INFO_MSG_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BANDIT_FILES.o: BANDIT/BANDIT_FILES.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/BANDIT_FILES_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CHECK_TE_MATRIX.o: EMG/EMG1/CHECK_TE_MATRIX.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/CHECK_TE_MATRIX_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ELMDAT1.o: EMG/EMG1/ELMDAT1.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/ELMDAT1_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ELMDAT2.o: EMG/EMG1/ELMDAT2.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/ELMDAT2_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ELMGM1.o: EMG/EMG1/ELMGM1.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/PARAMS.o obj/MODEL_STUF.o obj/ELMGM1_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ELMGM2.o: EMG/EMG1/ELMGM2.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/MODEL_STUF.o obj/DEBUG_PARAMETERS.o obj/ELMGM2_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ELMGM3.o: EMG/EMG1/ELMGM3.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/MODEL_STUF.o obj/DEBUG_PARAMETERS.o obj/ELMGM3_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/EMG.o: EMG/EMG1/EMG.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/SCONTR.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/EMG_USE_IFs.o obj/SCONTR.o obj/MODEL_STUF.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_ELEM_AGRID_BGRID.o: EMG/EMG1/GET_ELEM_AGRID_BGRID.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/GET_ELEM_AGRID_BGRID_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_ELEM_ONAME.o: EMG/EMG1/GET_ELEM_ONAME.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/GET_ELEM_ONAME_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_ELGP.o: EMG/EMG1/GET_ELGP.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/GET_ELGP_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_MATANGLE_FROM_CID.o: EMG/EMG1/GET_MATANGLE_FROM_CID.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/PARAMS.o obj/MODEL_STUF.o obj/SUBR_BEGEND_LEVELS.o obj/GET_MATANGLE_FROM_CID_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_PCOMP_SECT_PROPS.o: EMG/EMG1/GET_PCOMP_SECT_PROPS.f90 obj/PENTIUM_II_KIND.o obj/SCONTR.o obj/IOUNT1.o obj/MODEL_STUF.o obj/PARAMS.o obj/CONSTANTS_1.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/GET_PCOMP_SECT_PROPS_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GRID_ELEM_CONN_TABLE.o: EMG/EMG1/GRID_ELEM_CONN_TABLE.f90 obj/PENTIUM_II_KIND.o obj/SCONTR.o obj/IOUNT1.o obj/TIMDAT.o obj/MODEL_STUF.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/GRID_ELEM_CONN_TABLE_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/IS_ELEM_PCOMP_PROPS.o: EMG/EMG1/IS_ELEM_PCOMP_PROPS.f90 obj/PENTIUM_II_KIND.o obj/SCONTR.o obj/MODEL_STUF.o obj/IS_ELEM_PCOMP_PROPS_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ROT_COMP_ELEM_AXES.o: EMG/EMG1/ROT_COMP_ELEM_AXES.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/MODEL_STUF.o obj/SUBR_BEGEND_LEVELS.o obj/ROT_COMP_ELEM_AXES_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SHELL_ABD_MATRICES.o: EMG/EMG1/SHELL_ABD_MATRICES.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/PARAMS.o obj/MODEL_STUF.o obj/SUBR_BEGEND_LEVELS.o obj/SHELL_ABD_MATRICES_USE_IFs.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SOLVE_SHELL_ALP.o: EMG/EMG1/SOLVE_SHELL_ALP.f90 obj/PENTIUM_II_KIND.o obj/SCONTR.o obj/PARAMS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/SOLVE_SHELL_ALP_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_PCOMP_EQUIV.o: EMG/EMG1/WRITE_PCOMP_EQUIV.f90 obj/PENTIUM_II_KIND.o obj/CONSTANTS_1.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/MODEL_STUF.o obj/TIMDAT.o obj/WRITE_PCOMP_EQUIV_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ELMOFF.o: EMG/EMG2/ELMOFF.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/ELMOFF_USE_IFs.o obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ELMOUT.o: EMG/EMG2/ELMOUT.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/NONLINEAR_PARAMS.o obj/MODEL_STUF.o obj/ELMOUT_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ELMTLB.o: EMG/EMG2/ELMTLB.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/ELMTLB_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BAR1.o: EMG/EMG3/BAR1.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/NONLINEAR_PARAMS.o obj/MODEL_STUF.o obj/DEBUG_PARAMETERS.o obj/BAR1_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BEAM.o: EMG/EMG3/BEAM.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/MODEL_STUF.o obj/SUBR_BEGEND_LEVELS.o obj/BAR1_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BREL1.o: EMG/EMG3/BREL1.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/MODEL_STUF.o obj/BREL1_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BUSH.o: EMG/EMG3/BUSH.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/SUBR_BEGEND_LEVELS.o obj/BUSH_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ELAS1.o: EMG/EMG3/ELAS1.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/ELAS1_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/KUSER1.o: EMG/EMG3/KUSER1.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/KUSER1_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/PINFLG.o: EMG/EMG3/PINFLG.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/MODEL_STUF.o obj/PINFLG_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ROD1.o: EMG/EMG3/ROD1.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/ROD1_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/USERIN.o: EMG/EMG3/USERIN.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/DOF_TABLES.o obj/PARAMS.o obj/INPUTT4_MATRICES.o obj/RIGID_BODY_DISP_MATS.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/SUBR_BEGEND_LEVELS.o obj/USERIN_USE_IFs.o obj/PENTIUM_II_KIND.o obj/SCONTR.o obj/IOUNT1.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/PENTIUM_II_KIND.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/PENTIUM_II_KIND.o obj/IOUNT1.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CALC_PHI_SQ.o: EMG/EMG4/CALC_PHI_SQ.f90 obj/PENTIUM_II_KIND.o obj/SCONTR.o obj/IOUNT1.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/MODEL_STUF.o obj/CALC_PHI_SQ_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_ELEM_NUM_PLIES.o: EMG/EMG4/GET_ELEM_NUM_PLIES.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/GET_ELEM_NUM_PLIES_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/QDEL1.o: EMG/EMG4/QDEL1.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/PARAMS.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/QDEL1_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/QMEM1.o: EMG/EMG4/QMEM1.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/DEBUG_PARAMETERS.o obj/QMEM1_USE_IFs.o obj/IOUNT1.o obj/CONSTANTS_1.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/QPLT1.o: EMG/EMG4/QPLT1.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/MODEL_STUF.o obj/QPLT1_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/QPLT2.o: EMG/EMG4/QPLT2.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/MODEL_STUF.o obj/DEBUG_PARAMETERS.o obj/QPLT2_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/QPLT3.o: EMG/EMG4/QPLT3.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/MACHINE_PARAMS.o obj/MODEL_STUF.o obj/DEBUG_PARAMETERS.o obj/QPLT3_USE_IFs.o obj/PENTIUM_II_KIND.o obj/SCONTR.o obj/IOUNT1.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/PARAMS.o obj/MODEL_STUF.o obj/CONSTANTS_1.o obj/SCONTR.o obj/IOUNT1.o obj/PARAMS.o obj/MODEL_STUF.o obj/CONSTANTS_1.o obj/PARAMS.o obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/CONSTANTS_1.o obj/PARAMS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/QSHEAR.o: EMG/EMG4/QSHEAR.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/DEBUG_PARAMETERS.o obj/QSHEAR_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/TMEM1.o: EMG/EMG4/TMEM1.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/TMEM1_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/TPLT1.o: EMG/EMG4/TPLT1.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/TPLT1_USE_IFs.o obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/TPLT2.o: EMG/EMG4/TPLT2.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/DEBUG_PARAMETERS.o obj/TPLT2_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/TREL1.o: EMG/EMG4/TREL1.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/TREL1_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/HEXA.o: EMG/EMG5/HEXA.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/SUBR_BEGEND_LEVELS.o obj/PARAMS.o obj/MODEL_STUF.o obj/HEXA_USE_IFs.o obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/PENTIUM_II_KIND.o obj/IOUNT1.o
	$(F77) $(FLAGS) -c $< -o $@
obj/PENTA.o: EMG/EMG5/PENTA.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/SUBR_BEGEND_LEVELS.o obj/PARAMS.o obj/MODEL_STUF.o obj/PENTA_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/TETRA.o: EMG/EMG5/TETRA.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/SUBR_BEGEND_LEVELS.o obj/PARAMS.o obj/MODEL_STUF.o obj/TETRA_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/B3D_ISOPARAMETRIC.o: EMG/EMG6/B3D_ISOPARAMETRIC.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/B3D_ISOPARAMETRIC_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BBDKQ.o: EMG/EMG6/BBDKQ.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/BBDKQ_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BBMIN3.o: EMG/EMG6/BBMIN3.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/BBMIN3_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BBMIN4.o: EMG/EMG6/BBMIN4.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/BBMIN4_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BCHECK_2D.o: EMG/EMG6/BCHECK_2D.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/BCHECK_2D_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BCHECK_3D.o: EMG/EMG6/BCHECK_3D.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/BCHECK_3D_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BMQMEM.o: EMG/EMG6/BMQMEM.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/MODEL_STUF.o obj/BMQMEM_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BSMIN3.o: EMG/EMG6/BSMIN3.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/BSMIN3_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BSMIN4.o: EMG/EMG6/BSMIN4.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/BSMIN4_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MIN4SH.o: EMG/EMG7/MIN4SH.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MIN4SH_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ORDER_GAUSS.o: EMG/EMG7/ORDER_GAUSS.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/CONSTANTS_GAUSS.o obj/MODEL_STUF.o obj/ORDER_GAUSS_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ORDER_TETRA.o: EMG/EMG7/ORDER_TETRA.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/ORDER_TETRA_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ORDER_TRIA.o: EMG/EMG7/ORDER_TRIA.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/ORDER_TRIA_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SHP2DQ.o: EMG/EMG7/SHP2DQ.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/SHP2DQ_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SHP3DH.o: EMG/EMG7/SHP3DH.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/SHP3DH_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SHP3DP.o: EMG/EMG7/SHP3DP.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/SHP3DP_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SHP3DT.o: EMG/EMG7/SHP3DT.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/SHP3DT_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/JAC2D.o: EMG/EMG8/JAC2D.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/MODEL_STUF.o obj/JAC2D_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/JAC3D.o: EMG/EMG8/JAC3D.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/MODEL_STUF.o obj/DEBUG_PARAMETERS.o obj/JAC3D_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MATERIAL_PROPS_2D.o: EMG/EMG8/MATERIAL_PROPS_2D.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/MODEL_STUF.o obj/MATERIAL_PROPS_2D_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MATERIAL_PROPS_3D.o: EMG/EMG8/MATERIAL_PROPS_3D.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/MODEL_STUF.o obj/MATERIAL_PROPS_3D_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MATGET.o: EMG/EMG8/MATGET.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/MATGET_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MATPUT.o: EMG/EMG8/MATPUT.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MATPUT_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ROT_AXES_MATL_TO_LOC.o: EMG/EMG8/ROT_AXES_MATL_TO_LOC.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/ROT_AXES_MATL_TO_LOC_USE_IFs.o obj/PENTIUM_II_KIND.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATED_MEMORY_Interface.o: Interfaces/ALLOCATED_MEMORY_Interface.f90 obj/PENTIUM_II_KIND.o obj/SCONTR.o obj/IOUNT1.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/PARAMS.o obj/ALLOCATED_ARRAY_DATA.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_CB_ELM_OTM_Interface.o: Interfaces/ALLOCATE_CB_ELM_OTM_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/CC_OUTPUT_DESCRIBERS.o obj/OUTPUT4_MATRICES.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_CB_GRD_OTM_Interface.o: Interfaces/ALLOCATE_CB_GRD_OTM_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/PARAMS.o obj/MODEL_STUF.o obj/OUTPUT4_MATRICES.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_COL_VEC_Interface.o: Interfaces/ALLOCATE_COL_VEC_Interface.f90 obj/PENTIUM_II_KIND.o obj/CONSTANTS_1.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/SUBR_BEGEND_LEVELS.o obj/OUTPUT4_MATRICES.o obj/COL_VECS.o obj/COL_VECS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_DOF_TABLES_Interface.o: Interfaces/ALLOCATE_DOF_TABLES_Interface.f90 obj/PENTIUM_II_KIND.o obj/CONSTANTS_1.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/SUBR_BEGEND_LEVELS.o obj/DOF_TABLES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_EIGEN1_MAT_Interface.o: Interfaces/ALLOCATE_EIGEN1_MAT_Interface.f90 obj/PENTIUM_II_KIND.o obj/CONSTANTS_1.o obj/SCONTR.o obj/IOUNT1.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/SUBR_BEGEND_LEVELS.o obj/EIGEN_MATRICES_1.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_EMS_ARRAYS_Interface.o: Interfaces/ALLOCATE_EMS_ARRAYS_Interface.f90 obj/PENTIUM_II_KIND.o obj/CONSTANTS_1.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/EMS_ARRAYS.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_FEMAP_DATA_Interface.o: Interfaces/ALLOCATE_FEMAP_DATA_Interface.f90 obj/PENTIUM_II_KIND.o obj/CONSTANTS_1.o obj/SCONTR.o obj/IOUNT1.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/FEMAP_ARRAYS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_FULL_MAT_Interface.o: Interfaces/ALLOCATE_FULL_MAT_Interface.f90 obj/PENTIUM_II_KIND.o obj/CONSTANTS_1.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/SUBR_BEGEND_LEVELS.o obj/FULL_MATRICES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_IN4_FILES_Interface.o: Interfaces/ALLOCATE_IN4_FILES_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/INPUTT4_MATRICES.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_L1_MGG_Interface.o: Interfaces/ALLOCATE_L1_MGG_Interface.f90 obj/PENTIUM_II_KIND.o obj/CONSTANTS_1.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/SPARSE_MATRICES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_L2_GMN_2_Interface.o: Interfaces/ALLOCATE_L2_GMN_2_Interface.f90 obj/PENTIUM_II_KIND.o obj/CONSTANTS_1.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/SUBR_BEGEND_LEVELS.o obj/SPARSE_MATRICES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_L2_GOA_2_Interface.o: Interfaces/ALLOCATE_L2_GOA_2_Interface.f90 obj/PENTIUM_II_KIND.o obj/CONSTANTS_1.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/SUBR_BEGEND_LEVELS.o obj/SPARSE_MATRICES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_L6_2_Interface.o: Interfaces/ALLOCATE_L6_2_Interface.f90 obj/PENTIUM_II_KIND.o obj/CONSTANTS_1.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/SUBR_BEGEND_LEVELS.o obj/SPARSE_MATRICES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_LAPACK_MAT_Interface.o: Interfaces/ALLOCATE_LAPACK_MAT_Interface.f90 obj/PENTIUM_II_KIND.o obj/CONSTANTS_1.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/ARPACK_MATRICES_1.o obj/LAPACK_DPB_MATRICES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_LINK9_STUF_Interface.o: Interfaces/ALLOCATE_LINK9_STUF_Interface.f90 obj/PENTIUM_II_KIND.o obj/CONSTANTS_1.o obj/SCONTR.o obj/IOUNT1.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/LINK9_STUFF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_MISC_MAT_Interface.o: Interfaces/ALLOCATE_MISC_MAT_Interface.f90 obj/PENTIUM_II_KIND.o obj/CONSTANTS_1.o obj/SCONTR.o obj/IOUNT1.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/MISC_MATRICES.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_MODEL_STUF_Interface.o: Interfaces/ALLOCATE_MODEL_STUF_Interface.f90 obj/PENTIUM_II_KIND.o obj/CONSTANTS_1.o obj/IOUNT1.o obj/SCONTR.o obj/SCONTR.o obj/SCONTR.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_NL_PARAMS_Interface.o: Interfaces/ALLOCATE_NL_PARAMS_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/NONLINEAR_PARAMS.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_RBGLOBAL_Interface.o: Interfaces/ALLOCATE_RBGLOBAL_Interface.f90 obj/PENTIUM_II_KIND.o obj/CONSTANTS_1.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/SUBR_BEGEND_LEVELS.o obj/RIGID_BODY_DISP_MATS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_SCR_CCS_MAT_Interface.o: Interfaces/ALLOCATE_SCR_CCS_MAT_Interface.f90 obj/PENTIUM_II_KIND.o obj/CONSTANTS_1.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/SUBR_BEGEND_LEVELS.o obj/SCRATCH_MATRICES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_SCR_CRS_MAT_Interface.o: Interfaces/ALLOCATE_SCR_CRS_MAT_Interface.f90 obj/PENTIUM_II_KIND.o obj/CONSTANTS_1.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/SUBR_BEGEND_LEVELS.o obj/SCRATCH_MATRICES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_SPARSE_ALG_Interface.o: Interfaces/ALLOCATE_SPARSE_ALG_Interface.f90 obj/PENTIUM_II_KIND.o obj/CONSTANTS_1.o obj/SCONTR.o obj/IOUNT1.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/SUBR_BEGEND_LEVELS.o obj/SPARSE_ALG_ARRAYS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_SPARSE_MAT_Interface.o: Interfaces/ALLOCATE_SPARSE_MAT_Interface.f90 obj/PENTIUM_II_KIND.o obj/CONSTANTS_1.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/SUBR_BEGEND_LEVELS.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_STF_ARRAYS_Interface.o: Interfaces/ALLOCATE_STF_ARRAYS_Interface.f90 obj/PENTIUM_II_KIND.o obj/CONSTANTS_1.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/NONLINEAR_PARAMS.o obj/STF_ARRAYS.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_TEMPLATE_Interface.o: Interfaces/ALLOCATE_TEMPLATE_Interface.f90 obj/PENTIUM_II_KIND.o obj/CONSTANTS_1.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/STF_TEMPLATE_ARRAYS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ARPACK_INFO_MSG_Interface.o: Interfaces/ARPACK_INFO_MSG_Interface.f90 obj/PENTIUM_II_KIND.o obj/SCONTR.o obj/IOUNT1.o obj/PARAMS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ARRAY_SIZE_ERROR_1_Interface.o: Interfaces/ARRAY_SIZE_ERROR_1_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/AUTOSPC_SUMMARY_MSGS_Interface.o: Interfaces/AUTOSPC_SUMMARY_MSGS_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/PARAMS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/B3D_ISOPARAMETRIC_Interface.o: Interfaces/B3D_ISOPARAMETRIC_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BANDGEN_LAPACK_DGB_Interface.o: Interfaces/BANDGEN_LAPACK_DGB_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BANDGEN_LAPACK_DPB_Interface.o: Interfaces/BANDGEN_LAPACK_DPB_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BANDIT_FILES_Interface.o: Interfaces/BANDIT_FILES_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BANDSIZ_Interface.o: Interfaces/BANDSIZ_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BAR1_Interface.o: Interfaces/BAR1_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/NONLINEAR_PARAMS.o obj/MODEL_STUF.o obj/DEBUG_PARAMETERS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BAR_MARGIN_Interface.o: Interfaces/BAR_MARGIN_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BBDKQ_Interface.o: Interfaces/BBDKQ_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BBMIN3_Interface.o: Interfaces/BBMIN3_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BBMIN4_Interface.o: Interfaces/BBMIN4_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BCHECK_2D_Interface.o: Interfaces/BCHECK_2D_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BCHECK_3D_Interface.o: Interfaces/BCHECK_3D_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_ASET1_Interface.o: Interfaces/BD_ASET1_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/DOF_TABLES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_ASET_Interface.o: Interfaces/BD_ASET_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/DOF_TABLES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_BAROR0_Interface.o: Interfaces/BD_BAROR0_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_BAROR_Interface.o: Interfaces/BD_BAROR_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_BEAMOR0_Interface.o: Interfaces/BD_BEAMOR0_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_BEAMOR_Interface.o: Interfaces/BD_BEAMOR_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CBAR0_Interface.o: Interfaces/BD_CBAR0_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CBAR_Interface.o: Interfaces/BD_CBAR_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CBUSH0_Interface.o: Interfaces/BD_CBUSH0_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CBUSH_Interface.o: Interfaces/BD_CBUSH_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CELAS1_Interface.o: Interfaces/BD_CELAS1_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CELAS2_Interface.o: Interfaces/BD_CELAS2_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CELAS3_Interface.o: Interfaces/BD_CELAS3_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CELAS4_Interface.o: Interfaces/BD_CELAS4_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CHEXA0_Interface.o: Interfaces/BD_CHEXA0_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CHEXA_Interface.o: Interfaces/BD_CHEXA_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CMASS1_Interface.o: Interfaces/BD_CMASS1_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CMASS2_Interface.o: Interfaces/BD_CMASS2_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CMASS3_Interface.o: Interfaces/BD_CMASS3_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CMASS4_Interface.o: Interfaces/BD_CMASS4_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CONM2_Interface.o: Interfaces/BD_CONM2_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CONROD_Interface.o: Interfaces/BD_CONROD_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CORD_Interface.o: Interfaces/BD_CORD_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CPENTA0_Interface.o: Interfaces/BD_CPENTA0_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CPENTA_Interface.o: Interfaces/BD_CPENTA_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CQUAD0_Interface.o: Interfaces/BD_CQUAD0_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CQUAD_Interface.o: Interfaces/BD_CQUAD_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CROD_Interface.o: Interfaces/BD_CROD_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CSHEAR_Interface.o: Interfaces/BD_CSHEAR_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CTETRA0_Interface.o: Interfaces/BD_CTETRA0_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CTETRA_Interface.o: Interfaces/BD_CTETRA_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CTRIA0_Interface.o: Interfaces/BD_CTRIA0_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CTRIA_Interface.o: Interfaces/BD_CTRIA_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CUSER1_Interface.o: Interfaces/BD_CUSER1_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CUSERIN0_Interface.o: Interfaces/BD_CUSERIN0_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CUSERIN_Interface.o: Interfaces/BD_CUSERIN_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_DEBUG0_Interface.o: Interfaces/BD_DEBUG0_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/DEBUG_PARAMETERS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_DEBUG_Interface.o: Interfaces/BD_DEBUG_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/DEBUG_PARAMETERS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_EIGRL_Interface.o: Interfaces/BD_EIGRL_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_EIGR_Interface.o: Interfaces/BD_EIGR_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_FORMOM_Interface.o: Interfaces/BD_FORMOM_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_GRAV_Interface.o: Interfaces/BD_GRAV_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_GRDSET0_Interface.o: Interfaces/BD_GRDSET0_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_GRDSET_Interface.o: Interfaces/BD_GRDSET_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_GRID_Interface.o: Interfaces/BD_GRID_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_IMBEDDED_BLANK_Interface.o: Interfaces/BD_IMBEDDED_BLANK_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_LOAD0_Interface.o: Interfaces/BD_LOAD0_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_LOAD_Interface.o: Interfaces/BD_LOAD_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_MAT1_Interface.o: Interfaces/BD_MAT1_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_MAT2_Interface.o: Interfaces/BD_MAT2_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/PARAMS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_MAT8_Interface.o: Interfaces/BD_MAT8_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_MAT9_Interface.o: Interfaces/BD_MAT9_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/PARAMS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_MPC0_Interface.o: Interfaces/BD_MPC0_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_MPCADD0_Interface.o: Interfaces/BD_MPCADD0_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_MPCADD_Interface.o: Interfaces/BD_MPCADD_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_MPC_Interface.o: Interfaces/BD_MPC_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_NLPARM_Interface.o: Interfaces/BD_NLPARM_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/NONLINEAR_PARAMS.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_PARAM0_Interface.o: Interfaces/BD_PARAM0_Interface.f90 obj/PENTIUM_II_KIND.o obj/SCONTR.o obj/IOUNT1.o obj/TIMDAT.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_PARAM_Interface.o: Interfaces/BD_PARAM_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MACHINE_PARAMS.o obj/DOF_TABLES.o obj/PARAMS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_PARVEC1_Interface.o: Interfaces/BD_PARVEC1_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/OUTPUT4_MATRICES.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/DOF_TABLES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_PARVEC_Interface.o: Interfaces/BD_PARVEC_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/OUTPUT4_MATRICES.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/DOF_TABLES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_PBARL_Interface.o: Interfaces/BD_PBARL_Interface.f90 obj/PENTIUM_II_KIND.o obj/DERIVED_DATA_TYPES.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/CONSTANTS_1.o obj/TIMDAT.o obj/MODEL_STUF.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_PBAR_Interface.o: Interfaces/BD_PBAR_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/PARAMS.o obj/SCONTR.o obj/CONSTANTS_1.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_PBEAM_Interface.o: Interfaces/BD_PBEAM_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/PARAMS.o obj/SCONTR.o obj/CONSTANTS_1.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/PARAMS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_PBUSH_Interface.o: Interfaces/BD_PBUSH_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/PARAMS.o obj/SCONTR.o obj/CONSTANTS_1.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_PCOMP0_Interface.o: Interfaces/BD_PCOMP0_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_PCOMP10_Interface.o: Interfaces/BD_PCOMP10_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_PCOMP1_Interface.o: Interfaces/BD_PCOMP1_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_PCOMP_Interface.o: Interfaces/BD_PCOMP_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_PELAS_Interface.o: Interfaces/BD_PELAS_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_PLOAD2_Interface.o: Interfaces/BD_PLOAD2_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_PLOAD4_Interface.o: Interfaces/BD_PLOAD4_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_PLOTEL_Interface.o: Interfaces/BD_PLOTEL_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_PMASS_Interface.o: Interfaces/BD_PMASS_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_PROD_Interface.o: Interfaces/BD_PROD_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_PSHEAR_Interface.o: Interfaces/BD_PSHEAR_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_PSHEL_Interface.o: Interfaces/BD_PSHEL_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_PSOLID_Interface.o: Interfaces/BD_PSOLID_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_PUSER1_Interface.o: Interfaces/BD_PUSER1_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_PUSERIN_Interface.o: Interfaces/BD_PUSERIN_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_RBAR_Interface.o: Interfaces/BD_RBAR_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_RBE1_Interface.o: Interfaces/BD_RBE1_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_RBE2_Interface.o: Interfaces/BD_RBE2_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_RBE30_Interface.o: Interfaces/BD_RBE30_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_RBE3_Interface.o: Interfaces/BD_RBE3_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_RFORCE_Interface.o: Interfaces/BD_RFORCE_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_RSPLINE0_Interface.o: Interfaces/BD_RSPLINE0_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_RSPLINE_Interface.o: Interfaces/BD_RSPLINE_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_SEQGP_Interface.o: Interfaces/BD_SEQGP_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_SLOAD0_Interface.o: Interfaces/BD_SLOAD0_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_SLOAD_Interface.o: Interfaces/BD_SLOAD_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_SPC1_Interface.o: Interfaces/BD_SPC1_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/DOF_TABLES.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_SPCADD0_Interface.o: Interfaces/BD_SPCADD0_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_SPCADD_Interface.o: Interfaces/BD_SPCADD_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_SPC_Interface.o: Interfaces/BD_SPC_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/DOF_TABLES.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_SPOINT0_Interface.o: Interfaces/BD_SPOINT0_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_SPOINT_Interface.o: Interfaces/BD_SPOINT_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/MODEL_STUF.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_SUPORT_Interface.o: Interfaces/BD_SUPORT_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_TEMPD_Interface.o: Interfaces/BD_TEMPD_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_TEMPRP_Interface.o: Interfaces/BD_TEMPRP_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_TEMP_Interface.o: Interfaces/BD_TEMP_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_USET1_Interface.o: Interfaces/BD_USET1_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/DOF_TABLES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_USET_Interface.o: Interfaces/BD_USET_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/DOF_TABLES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BEAM_Interface.o: Interfaces/BEAM_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/MODEL_STUF.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BMQMEM_Interface.o: Interfaces/BMQMEM_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BREL1_Interface.o: Interfaces/BREL1_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BSMIN3_Interface.o: Interfaces/BSMIN3_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BSMIN4_Interface.o: Interfaces/BSMIN4_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BUILD_A_LR_Interface.o: Interfaces/BUILD_A_LR_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/COL_VECS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BUILD_F_AO_Interface.o: Interfaces/BUILD_F_AO_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/NONLINEAR_PARAMS.o obj/SPARSE_MATRICES.o obj/COL_VECS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BUILD_G_NM_Interface.o: Interfaces/BUILD_G_NM_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/SPARSE_MATRICES.o obj/COL_VECS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BUILD_N_FS_Interface.o: Interfaces/BUILD_N_FS_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/COL_VECS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BUSH_Interface.o: Interfaces/BUSH_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CALC_CB_MEFM_MPF_Interface.o: Interfaces/CALC_CB_MEFM_MPF_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTs_1.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/RIGID_BODY_DISP_MATS.o obj/SPARSE_MATRICES.o obj/SCRATCH_MATRICES.o obj/EIGEN_MATRICES_1.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CALC_ELEM_NODE_FORCES_Interface.o: Interfaces/CALC_ELEM_NODE_FORCES_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CALC_ELEM_STRAINS_Interface.o: Interfaces/CALC_ELEM_STRAINS_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/MODEL_STUF.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CALC_ELEM_STRESSES_Interface.o: Interfaces/CALC_ELEM_STRESSES_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/MODEL_STUF.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CALC_GEN_MASS_Interface.o: Interfaces/CALC_GEN_MASS_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/EIGEN_MATRICES_1.o obj/MODEL_STUF.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/LAPACK_BLAS_AUX.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CALC_KRRcb_Interface.o: Interfaces/CALC_KRRcb_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/PARAMS.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/SCRATCH_MATRICES.o obj/LAPACK_DPB_MATRICES.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CALC_MRN_Interface.o: Interfaces/CALC_MRN_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/PARAMS.o obj/EIGEN_MATRICES_1.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/SCRATCH_MATRICES.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CALC_MRRcb_Interface.o: Interfaces/CALC_MRRcb_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/PARAMS.o obj/RIGID_BODY_DISP_MATS.o obj/MODEL_STUF.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/SCRATCH_MATRICES.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CALC_PHIZL_Interface.o: Interfaces/CALC_PHIZL_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/CONSTANTS_1.o obj/PARAMS.o obj/TIMDAT.o obj/EIGEN_MATRICES_1.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/SCRATCH_MATRICES.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CALC_PHI_SQ_Interface.o: Interfaces/CALC_PHI_SQ_Interface.f90 obj/PENTIUM_II_KIND.o obj/SCONTR.o obj/IOUNT1.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CALC_TDOF_ROW_START_Interface.o: Interfaces/CALC_TDOF_ROW_START_Interface.f90 obj/PENTIUM_II_KIND.o obj/SCONTR.o obj/IOUNT1.o obj/TIMDAT.o obj/DOF_TABLES.o obj/DEBUG_PARAMETERS.o obj/MODEL_STUF.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CALC_VEC_SORT_ORDER_Interface.o: Interfaces/CALC_VEC_SORT_ORDER_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CARD_FLDS_NOT_BLANK_Interface.o: Interfaces/CARD_FLDS_NOT_BLANK_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_ACCE_Interface.o: Interfaces/CC_ACCE_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CC_OUTPUT_DESCRIBERS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_DISP_Interface.o: Interfaces/CC_DISP_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CC_OUTPUT_DESCRIBERS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_ECHO_Interface.o: Interfaces/CC_ECHO_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_ELDA_Interface.o: Interfaces/CC_ELDA_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_ELFO_Interface.o: Interfaces/CC_ELFO_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_ENFO_Interface.o: Interfaces/CC_ENFO_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_GPFO_Interface.o: Interfaces/CC_GPFO_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_LABE_Interface.o: Interfaces/CC_LABE_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_LOAD_Interface.o: Interfaces/CC_LOAD_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_METH_Interface.o: Interfaces/CC_METH_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_MPCF_Interface.o: Interfaces/CC_MPCF_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CC_OUTPUT_DESCRIBERS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_MPC_Interface.o: Interfaces/CC_MPC_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_NLPARM_Interface.o: Interfaces/CC_NLPARM_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/NONLINEAR_PARAMS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_OLOA_Interface.o: Interfaces/CC_OLOA_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CC_OUTPUT_DESCRIBERS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_OUTPUTS_Interface.o: Interfaces/CC_OUTPUTS_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_SET0_Interface.o: Interfaces/CC_SET0_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_SET_Interface.o: Interfaces/CC_SET_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_SPCF_Interface.o: Interfaces/CC_SPCF_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CC_OUTPUT_DESCRIBERS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_SPC_Interface.o: Interfaces/CC_SPC_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_STRE_Interface.o: Interfaces/CC_STRE_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_STRN_Interface.o: Interfaces/CC_STRN_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_SUBC_Interface.o: Interfaces/CC_SUBC_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_SUBT_Interface.o: Interfaces/CC_SUBT_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_TEMP_Interface.o: Interfaces/CC_TEMP_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_TITL_Interface.o: Interfaces/CC_TITL_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CHAR_FLD_Interface.o: Interfaces/CHAR_FLD_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CHECK_BAR_MOIs_Interface.o: Interfaces/CHECK_BAR_MOIs_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CHECK_MAT_INVERSE_Interface.o: Interfaces/CHECK_MAT_INVERSE_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/PARAMS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CHECK_TE_MATRIX_Interface.o: Interfaces/CHECK_TE_MATRIX_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CHK_ARRAY_ALLOC_STAT_Interface.o: Interfaces/CHK_ARRAY_ALLOC_STAT_Interface.f90 obj/SCONTR.o obj/IOUNT1.o obj/ARPACK_MATRICES_1.o obj/COL_VECS.o obj/DOF_TABLES.o obj/EIGEN_MATRICES_1.o obj/EMS_ARRAYS.o obj/FEMAP_ARRAYS.o obj/FULL_MATRICES.o obj/LAPACK_DPB_MATRICES.o obj/LINK9_STUFF.o obj/MODEL_STUF.o obj/NONLINEAR_PARAMS.o obj/INPUTT4_MATRICES.o obj/RIGID_BODY_DISP_MATS.o obj/SCRATCH_MATRICES.o obj/SPARSE_ALG_ARRAYS.o obj/SPARSE_MATRICES.o obj/STF_ARRAYS.o obj/STF_TEMPLATE_ARRAYS.o obj/OUTPUT4_MATRICES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CHK_CC_CMD_DESCRIBERS_Interface.o: Interfaces/CHK_CC_CMD_DESCRIBERS_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CC_OUTPUT_DESCRIBERS.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CLOSE_LIJFILES_Interface.o: Interfaces/CLOSE_LIJFILES_Interface.f90 obj/PENTIUM_II_KIND.o obj/SCONTR.o obj/IOUNT1.o obj/IOUNT1.o obj/IOUNT1.o obj/TIMDAT.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CLOSE_OUTFILES_Interface.o: Interfaces/CLOSE_OUTFILES_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CNT_NONZ_IN_FULL_MAT_Interface.o: Interfaces/CNT_NONZ_IN_FULL_MAT_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/DEBUG_PARAMETERS.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/COND_NUM_Interface.o: Interfaces/COND_NUM_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/CONSTANTS_1.o obj/PARAMS.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/LAPACK_LIN_EQN_DPB.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CONM2_PROC_1_Interface.o: Interfaces/CONM2_PROC_1_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/DEBUG_PARAMETERS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CONM2_PROC_2_Interface.o: Interfaces/CONM2_PROC_2_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/DEBUG_PARAMETERS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CONVERT_INT_TO_CHAR_Interface.o: Interfaces/CONVERT_INT_TO_CHAR_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CONVERT_VEC_COORD_SYS_Interface.o: Interfaces/CONVERT_VEC_COORD_SYS_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/MODEL_STUF.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CORD_PROC_Interface.o: Interfaces/CORD_PROC_Interface.f90 obj/PENTIUM_II_KIND.o obj/CONSTANTS_1.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CRDERR_Interface.o: Interfaces/CRDERR_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CROSS_Interface.o: Interfaces/CROSS_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CRS_NONSYM_TO_CRS_SYM_Interface.o: Interfaces/CRS_NONSYM_TO_CRS_SYM_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CRS_SYM_TO_CRS_NONSYM_Interface.o: Interfaces/CRS_SYM_TO_CRS_NONSYM_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CSHIFT_Interface.o: Interfaces/CSHIFT_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DATA_SET_NAME_ERROR_Interface.o: Interfaces/DATA_SET_NAME_ERROR_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DATA_SET_SIZE_ERROR_Interface.o: Interfaces/DATA_SET_SIZE_ERROR_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEALLOCATE_CB_ELM_OTM_Interface.o: Interfaces/DEALLOCATE_CB_ELM_OTM_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/OUTPUT4_MATRICES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEALLOCATE_CB_GRD_OTM_Interface.o: Interfaces/DEALLOCATE_CB_GRD_OTM_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/OUTPUT4_MATRICES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEALLOCATE_COL_VEC_Interface.o: Interfaces/DEALLOCATE_COL_VEC_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/OUTPUT4_MATRICES.o obj/COL_VECS.o obj/COL_VECS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEALLOCATE_DOF_TABLES_Interface.o: Interfaces/DEALLOCATE_DOF_TABLES_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/DOF_TABLES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEALLOCATE_EIGEN1_MAT_Interface.o: Interfaces/DEALLOCATE_EIGEN1_MAT_Interface.f90 obj/PENTIUM_II_KIND.o obj/SCONTR.o obj/IOUNT1.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/EIGEN_MATRICES_1.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEALLOCATE_EMS_ARRAYS_Interface.o: Interfaces/DEALLOCATE_EMS_ARRAYS_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/EMS_ARRAYS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEALLOCATE_FEMAP_DATA_Interface.o: Interfaces/DEALLOCATE_FEMAP_DATA_Interface.f90 obj/PENTIUM_II_KIND.o obj/SCONTR.o obj/IOUNT1.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/FEMAP_ARRAYS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEALLOCATE_FULL_MAT_Interface.o: Interfaces/DEALLOCATE_FULL_MAT_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/FULL_MATRICES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEALLOCATE_IN4_FILES_Interface.o: Interfaces/DEALLOCATE_IN4_FILES_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/CONSTANTS_1.o obj/INPUTT4_MATRICES.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEALLOCATE_L1_MGG_Interface.o: Interfaces/DEALLOCATE_L1_MGG_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/SPARSE_MATRICES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEALLOCATE_L2_GMN_2_Interface.o: Interfaces/DEALLOCATE_L2_GMN_2_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/SUBR_BEGEND_LEVELS.o obj/SPARSE_MATRICES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEALLOCATE_L2_GOA_2_Interface.o: Interfaces/DEALLOCATE_L2_GOA_2_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/SUBR_BEGEND_LEVELS.o obj/SPARSE_MATRICES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEALLOCATE_L6_2_Interface.o: Interfaces/DEALLOCATE_L6_2_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/SPARSE_MATRICES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEALLOCATE_LAPACK_MAT_Interface.o: Interfaces/DEALLOCATE_LAPACK_MAT_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/ARPACK_MATRICES_1.o obj/LAPACK_DPB_MATRICES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEALLOCATE_LINK9_STUF_Interface.o: Interfaces/DEALLOCATE_LINK9_STUF_Interface.f90 obj/PENTIUM_II_KIND.o obj/SCONTR.o obj/IOUNT1.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/LINK9_STUFF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEALLOCATE_MISC_MAT_Interface.o: Interfaces/DEALLOCATE_MISC_MAT_Interface.f90 obj/PENTIUM_II_KIND.o obj/SCONTR.o obj/IOUNT1.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/CONSTANTS_1.o obj/MISC_MATRICES.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEALLOCATE_MODEL_STUF_Interface.o: Interfaces/DEALLOCATE_MODEL_STUF_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEALLOCATE_NL_PARAMS_Interface.o: Interfaces/DEALLOCATE_NL_PARAMS_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/CONSTANTS_1.o obj/NONLINEAR_PARAMS.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEALLOCATE_RBGLOBAL_Interface.o: Interfaces/DEALLOCATE_RBGLOBAL_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/RIGID_BODY_DISP_MATS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEALLOCATE_SCR_MAT_Interface.o: Interfaces/DEALLOCATE_SCR_MAT_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/SCRATCH_MATRICES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEALLOCATE_SPARSE_ALG_Interface.o: Interfaces/DEALLOCATE_SPARSE_ALG_Interface.f90 obj/PENTIUM_II_KIND.o obj/SCONTR.o obj/IOUNT1.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/SPARSE_ALG_ARRAYS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEALLOCATE_SPARSE_MAT_Interface.o: Interfaces/DEALLOCATE_SPARSE_MAT_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEALLOCATE_STF_ARRAYS_Interface.o: Interfaces/DEALLOCATE_STF_ARRAYS_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/STF_ARRAYS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEALLOCATE_TEMPLATE_Interface.o: Interfaces/DEALLOCATE_TEMPLATE_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/STF_TEMPLATE_ARRAYS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DOF_PROC_Interface.o: Interfaces/DOF_PROC_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/EC_DEBUG_Interface.o: Interfaces/EC_DEBUG_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/DEBUG_PARAMETERS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/EC_IN4FIL_Interface.o: Interfaces/EC_IN4FIL_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/EC_OUTPUT4_Interface.o: Interfaces/EC_OUTPUT4_Interface.f90 obj/PENTIUM_II_KIND.o obj/SCONTR.o obj/SUBR_BEGEND_LEVELS.o obj/IOUNT1.o obj/DEBUG_PARAMETERS.o obj/OUTPUT4_MATRICES.o obj/TIMDAT.o
	$(F77) $(FLAGS) -c $< -o $@
obj/EC_PARTN_Interface.o: Interfaces/EC_PARTN_Interface.f90 obj/PENTIUM_II_KIND.o obj/SCONTR.o obj/SUBR_BEGEND_LEVELS.o obj/IOUNT1.o obj/DEBUG_PARAMETERS.o obj/OUTPUT4_MATRICES.o obj/TIMDAT.o
	$(F77) $(FLAGS) -c $< -o $@
obj/EIG_GIV_MGIV_Interface.o: Interfaces/EIG_GIV_MGIV_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/EIGEN_MATRICES_1.o obj/MODEL_STUF.o obj/LAPACK_DPB_MATRICES.o obj/SPARSE_MATRICES.o obj/DEBUG_PARAMETERS.o obj/LAPACK_GIV_MGIV_EIG.o
	$(F77) $(FLAGS) -c $< -o $@
obj/EIG_INV_PWR_Interface.o: Interfaces/EIG_INV_PWR_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/EIGEN_MATRICES_1.o obj/MODEL_STUF.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/LAPACK_LIN_EQN_DPB.o obj/DEBUG_PARAMETERS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/EIG_LANCZOS_ARPACK_Interface.o: Interfaces/EIG_LANCZOS_ARPACK_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/PARAMS.o obj/DOF_TABLES.o obj/SUBR_BEGEND_LEVELS.o obj/EIGEN_MATRICES_1.o obj/MODEL_STUF.o obj/ARPACK_MATRICES_1.o obj/SPARSE_MATRICES.o obj/ARPACK_LANCZOS_EIG.o
	$(F77) $(FLAGS) -c $< -o $@
obj/EIG_SUMMARY_Interface.o: Interfaces/EIG_SUMMARY_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/EIGEN_MATRICES_1.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ELAS1_Interface.o: Interfaces/ELAS1_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ELEM_PROP_MATL_IIDS_Interface.o: Interfaces/ELEM_PROP_MATL_IIDS_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ELEM_STRE_STRN_ARRAYS_Interface.o: Interfaces/ELEM_STRE_STRN_ARRAYS_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/DEBUG_PARAMETERS.o obj/PARAMS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ELEM_TRANSFORM_LBG_Interface.o: Interfaces/ELEM_TRANSFORM_LBG_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ELEPRO_Interface.o: Interfaces/ELEPRO_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ELESORT_Interface.o: Interfaces/ELESORT_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/DEBUG_PARAMETERS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ELMDAT1_Interface.o: Interfaces/ELMDAT1_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/MODEL_STUF.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ELMDAT2_Interface.o: Interfaces/ELMDAT2_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ELMDIS_Interface.o: Interfaces/ELMDIS_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/DOF_TABLES.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/COL_VECS.o obj/DEBUG_PARAMETERS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ELMDIS_PLY_Interface.o: Interfaces/ELMDIS_PLY_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/CONSTANTS_1.o obj/TIMDAT.o obj/MODEL_STUF.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ELMGM1_Interface.o: Interfaces/ELMGM1_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/PARAMS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ELMGM2_Interface.o: Interfaces/ELMGM2_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/MODEL_STUF.o obj/DEBUG_PARAMETERS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ELMGM3_Interface.o: Interfaces/ELMGM3_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/MODEL_STUF.o obj/DEBUG_PARAMETERS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ELMOFF_Interface.o: Interfaces/ELMOFF_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ELMOUT_Interface.o: Interfaces/ELMOUT_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/NONLINEAR_PARAMS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ELMTLB_Interface.o: Interfaces/ELMTLB_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ELSAVE_Interface.o: Interfaces/ELSAVE_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/EMG_Interface.o: Interfaces/EMG_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/SCONTR.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/EMP0_Interface.o: Interfaces/EMP0_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/EMP_Interface.o: Interfaces/EMP_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/DOF_TABLES.o obj/MODEL_STUF.o obj/EMS_ARRAYS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/EPSCALC_Interface.o: Interfaces/EPSCALC_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/MACHINE_PARAMS.o obj/LAPACK_DPB_MATRICES.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/COL_VECS.o obj/LAPACK_BLAS_AUX.o
	$(F77) $(FLAGS) -c $< -o $@
obj/EPTL_Interface.o: Interfaces/EPTL_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/CONSTANTS_1.o obj/PARAMS.o obj/TIMDAT.o obj/DOF_TABLES.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ESP0_FINAL_Interface.o: Interfaces/ESP0_FINAL_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/DOF_TABLES.o obj/MODEL_STUF.o obj/STF_ARRAYS.o obj/DEBUG_PARAMETERS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ESP0_Interface.o: Interfaces/ESP0_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/NONLINEAR_PARAMS.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ESP_Interface.o: Interfaces/ESP_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/DOF_TABLES.o obj/NONLINEAR_PARAMS.o obj/MODEL_STUF.o obj/STF_ARRAYS.o obj/STF_TEMPLATE_ARRAYS.o obj/DEBUG_PARAMETERS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/EXPAND_PHIXA_TO_PHIXG_Interface.o: Interfaces/EXPAND_PHIXA_TO_PHIXG_Interface.f90 obj/PENTIUM_II_KIND.o obj/CONSTANTS_1.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/COL_VECS.o obj/PARAMS.o obj/DEBUG_PARAMETERS.o obj/SPARSE_MATRICES.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/FBS_LAPACK_Interface.o: Interfaces/FBS_LAPACK_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/PARAMS.o obj/LAPACK_DPB_MATRICES.o obj/DEBUG_PARAMETERS.o obj/MACHINE_PARAMS.o obj/LAPACK_LIN_EQN_DPB.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/FFIELD2_Interface.o: Interfaces/FFIELD2_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/FFIELD_Interface.o: Interfaces/FFIELD_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/FILERR_Interface.o: Interfaces/FILERR_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/FILE_CLOSE_Interface.o: Interfaces/FILE_CLOSE_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/FILE_INQUIRE_Interface.o: Interfaces/FILE_INQUIRE_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/IOUNT1.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/FILE_OPEN_Interface.o: Interfaces/FILE_OPEN_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/MYSTRAN_Version.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/FORCE_MOM_PROC_Interface.o: Interfaces/FORCE_MOM_PROC_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/DOF_TABLES.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/FULL_TO_SPARSE_CRS_Interface.o: Interfaces/FULL_TO_SPARSE_CRS_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GEN_T0L_Interface.o: Interfaces/GEN_T0L_Interface.f90 obj/PENTIUM_II_KIND.o obj/CONSTANTS_1.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_ANSID_Interface.o: Interfaces/GET_ANSID_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_ARRAY_ROW_NUM_Interface.o: Interfaces/GET_ARRAY_ROW_NUM_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_CHAR_STRING_END_Interface.o: Interfaces/GET_CHAR_STRING_END_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_COMMAND_LINE_Interface.o: Interfaces/GET_COMMAND_LINE_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_COMP_SHELL_ALLOWS_Interface.o: Interfaces/GET_COMP_SHELL_ALLOWS_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/TIMDAT.o obj/SCONTR.o obj/MACHINE_PARAMS.o obj/MODEL_STUF.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_ELEM_AGRID_BGRID_Interface.o: Interfaces/GET_ELEM_AGRID_BGRID_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_ELEM_NUM_PLIES_Interface.o: Interfaces/GET_ELEM_NUM_PLIES_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_ELEM_ONAME_Interface.o: Interfaces/GET_ELEM_ONAME_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_ELGP_Interface.o: Interfaces/GET_ELGP_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_FORMATTED_INTEGER_Interface.o: Interfaces/GET_FORMATTED_INTEGER_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_GRID_6X6_MASS_Interface.o: Interfaces/GET_GRID_6X6_MASS_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/DOF_TABLES.o obj/SPARSE_MATRICES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_GRID_AND_COMP_Interface.o: Interfaces/GET_GRID_AND_COMP_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/DOF_TABLES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_GRID_NUM_COMPS_Interface.o: Interfaces/GET_GRID_NUM_COMPS_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/MODEL_STUF.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_I2_MAT_FROM_I_MAT_Interface.o: Interfaces/GET_I2_MAT_FROM_I_MAT_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_INI_FILNAM_Interface.o: Interfaces/GET_INI_FILNAM_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_I_MAT_FROM_I2_MAT_Interface.o: Interfaces/GET_I_MAT_FROM_I2_MAT_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_MACHINE_PARAMS_Interface.o: Interfaces/GET_MACHINE_PARAMS_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/MACHINE_PARAMS.o obj/DEBUG_PARAMETERS.o obj/LAPACK_BLAS_AUX.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_MATANGLE_FROM_CID_Interface.o: Interfaces/GET_MATANGLE_FROM_CID_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/PARAMS.o obj/MODEL_STUF.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_MATRIX_DIAG_STATS_Interface.o: Interfaces/GET_MATRIX_DIAG_STATS_Interface.f90 obj/PENTIUM_II_KIND.o obj/SCONTR.o obj/IOUNT1.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/PARAMS.o obj/DOF_TABLES.o obj/DEBUG_PARAMETERS.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_MAX_MIN_ABS_STR_Interface.o: Interfaces/GET_MAX_MIN_ABS_STR_Interface.f90 obj/PENTIUM_II_KIND.o obj/SCONTR.o obj/IOUNT1.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/MACHINE_PARAMS.o obj/LINK9_STUFF.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_MYSTRAN_DIR_Interface.o: Interfaces/GET_MYSTRAN_DIR_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_OU4_MAT_STATS_Interface.o: Interfaces/GET_OU4_MAT_STATS_Interface.f90 obj/PENTIUM_II_KIND.o obj/SCONTR.o obj/IOUNT1.o obj/MODEL_STUF.o obj/PARAMS.o obj/OUTPUT4_MATRICES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_PCOMP_SECT_PROPS_Interface.o: Interfaces/GET_PCOMP_SECT_PROPS_Interface.f90 obj/PENTIUM_II_KIND.o obj/SCONTR.o obj/IOUNT1.o obj/MODEL_STUF.o obj/PARAMS.o obj/CONSTANTS_1.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_SETID_Interface.o: Interfaces/GET_SETID_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_SPARSE_CRS_COL_Interface.o: Interfaces/GET_SPARSE_CRS_COL_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_SPARSE_CRS_ROW_Interface.o: Interfaces/GET_SPARSE_CRS_ROW_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_SPARSE_MAT_TERM_Interface.o: Interfaces/GET_SPARSE_MAT_TERM_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_UG_123_IN_GRD_ORD_Interface.o: Interfaces/GET_UG_123_IN_GRD_ORD_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/MODEL_STUF.o obj/DOF_TABLES.o obj/COL_VECS.o obj/MISC_MATRICES.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_VEC_MIN_MAX_ABS_Interface.o: Interfaces/GET_VEC_MIN_MAX_ABS_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MACHINE_PARAMS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GPWG_Interface.o: Interfaces/GPWG_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/DEBUG_PARAMETERS.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GPWG_PMOI_Interface.o: Interfaces/GPWG_PMOI_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/PARAMS.o obj/LAPACK_STD_EIG_1.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GPWG_USERIN_Interface.o: Interfaces/GPWG_USERIN_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GP_FORCE_BALANCE_PROC_Interface.o: Interfaces/GP_FORCE_BALANCE_PROC_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/DOF_TABLES.o obj/DEBUG_PARAMETERS.o obj/MODEL_STUF.o obj/LINK9_STUFF.o obj/COL_VECS.o obj/PARAMS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GRAV_PROC_Interface.o: Interfaces/GRAV_PROC_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/PARAMS.o obj/CONSTANTS_1.o obj/DOF_TABLES.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GRID_ELEM_CONN_TABLE_Interface.o: Interfaces/GRID_ELEM_CONN_TABLE_Interface.f90 obj/PENTIUM_II_KIND.o obj/SCONTR.o obj/IOUNT1.o obj/TIMDAT.o obj/MODEL_STUF.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GRID_PROC_Interface.o: Interfaces/GRID_PROC_Interface.f90 obj/PENTIUM_II_KIND.o obj/CONSTANTS_1.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/HEXA_Interface.o: Interfaces/HEXA_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/SUBR_BEGEND_LEVELS.o obj/PARAMS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/I4FLD_Interface.o: Interfaces/I4FLD_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o
	$(F77) $(FLAGS) -c $< -o $@
obj/INDEP_FAILURE_INDEX_Interface.o: Interfaces/INDEP_FAILURE_INDEX_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/MACHINE_PARAMS.o obj/DEBUG_PARAMETERS.o obj/PARAMS.o obj/MODEL_STUF.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/INTERFACE_FORCE_LTM_Interface.o: Interfaces/INTERFACE_FORCE_LTM_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/SCRATCH_MATRICES.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/INVERT_EIGENS_Interface.o: Interfaces/INVERT_EIGENS_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MACHINE_PARAMS.o obj/MODEL_STUF.o obj/LAPACK_BLAS_AUX.o
	$(F77) $(FLAGS) -c $< -o $@
obj/INVERT_FF_MAT_Interface.o: Interfaces/INVERT_FF_MAT_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/LAPACK_SYM_MAT_INV.o
	$(F77) $(FLAGS) -c $< -o $@
obj/IP6CHK_Interface.o: Interfaces/IP6CHK_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/IS_ELEM_PCOMP_PROPS_Interface.o: Interfaces/IS_ELEM_PCOMP_PROPS_Interface.f90 obj/PENTIUM_II_KIND.o obj/SCONTR.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/IS_THIS_A_RESTART_Interface.o: Interfaces/IS_THIS_A_RESTART_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o
	$(F77) $(FLAGS) -c $< -o $@
obj/JAC2D_Interface.o: Interfaces/JAC2D_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/JAC3D_Interface.o: Interfaces/JAC3D_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/MODEL_STUF.o obj/DEBUG_PARAMETERS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/KGG_SINGULARITY_PROC_Interface.o: Interfaces/KGG_SINGULARITY_PROC_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/CONSTANTS_1.o obj/PARAMS.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/DOF_TABLES.o obj/DEBUG_PARAMETERS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/KUSER1_Interface.o: Interfaces/KUSER1_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/LEFT_ADJ_BDFLD_Interface.o: Interfaces/LEFT_ADJ_BDFLD_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/LINK0_Interface.o: Interfaces/LINK0_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/IOUNT1.o obj/IOUNT1.o obj/IOUNT1.o obj/IOUNT1.o obj/SCONTR.o obj/SCONTR.o obj/TIMDAT.o obj/DOF_TABLES.o obj/PARAMS.o obj/NONLINEAR_PARAMS.o obj/MACHINE_PARAMS.o obj/MODEL_STUF.o obj/DEBUG_PARAMETERS.o obj/BANDIT_MODULE.o obj/RIGID_BODY_DISP_MATS.o obj/SPARSE_MATRICES.o obj/OUTPUT4_MATRICES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/LINK1_Interface.o: Interfaces/LINK1_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/IOUNT1.o obj/IOUNT1.o obj/IOUNT1.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/DOF_TABLES.o obj/PARAMS.o obj/NONLINEAR_PARAMS.o obj/MODEL_STUF.o obj/DEBUG_PARAMETERS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/LINK1_RESTART_DATA_Interface.o: Interfaces/LINK1_RESTART_DATA_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/PARAMS.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/LINK2_Interface.o: Interfaces/LINK2_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/IOUNT1.o obj/IOUNT1.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/RIGID_BODY_DISP_MATS.o obj/PARAMS.o obj/NONLINEAR_PARAMS.o obj/DEBUG_PARAMETERS.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/OUTPUT4_MATRICES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/LINK3_Interface.o: Interfaces/LINK3_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/PARAMS.o obj/SPARSE_MATRICES.o obj/LAPACK_DPB_MATRICES.o obj/COL_VECS.o obj/MACHINE_PARAMS.o obj/DEBUG_PARAMETERS.o obj/LAPACK_BLAS_AUX.o obj/LAPACK_LIN_EQN_DPB.o
	$(F77) $(FLAGS) -c $< -o $@
obj/LINK4_Interface.o: Interfaces/LINK4_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/PARAMS.o obj/MODEL_STUF.o obj/SPARSE_MATRICES.o obj/OUTPUT4_MATRICES.o obj/EIGEN_MATRICES_1.o obj/LAPACK_DPB_MATRICES.o obj/DEBUG_PARAMETERS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/LINK5_Interface.o: Interfaces/LINK5_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/IOUNT1.o obj/IOUNT1.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/PARAMS.o obj/NONLINEAR_PARAMS.o obj/EIGEN_MATRICES_1.o obj/FULL_MATRICES.o obj/SPARSE_MATRICES.o obj/OUTPUT4_MATRICES.o obj/MISC_MATRICES.o obj/COL_VECS.o obj/DEBUG_PARAMETERS.o obj/DOF_TABLES.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/LINK6_Interface.o: Interfaces/LINK6_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/SCONTR.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/PARAMS.o obj/TIMDAT.o obj/MODEL_STUF.o obj/EIGEN_MATRICES_1.o obj/OUTPUT4_MATRICES.o obj/LAPACK_DPB_MATRICES.o obj/SPARSE_MATRICES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/LINK9S_Interface.o: Interfaces/LINK9S_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/LINK9_Interface.o: Interfaces/LINK9_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/IOUNT1.o obj/IOUNT1.o obj/IOUNT1.o obj/IOUNT1.o obj/SCONTR.o obj/SCONTR.o obj/CC_OUTPUT_DESCRIBERS.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/NONLINEAR_PARAMS.o obj/COL_VECS.o obj/EIGEN_MATRICES_1.o obj/OUTPUT4_MATRICES.o obj/OUTPUT4_MATRICES.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/DOF_TABLES.o obj/MODEL_STUF.o obj/LINK9_STUFF.o obj/DEBUG_PARAMETERS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/LOADB0_Interface.o: Interfaces/LOADB0_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/PARAMS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/LOADB_Interface.o: Interfaces/LOADB_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/PARAMS.o obj/OUTPUT4_MATRICES.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/LOADB_RESTART_Interface.o: Interfaces/LOADB_RESTART_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/DEBUG_PARAMETERS.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/LOADC0_Interface.o: Interfaces/LOADC0_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/LOADC_Interface.o: Interfaces/LOADC_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/CC_OUTPUT_DESCRIBERS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/LOADE0_Interface.o: Interfaces/LOADE0_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/LOADE_Interface.o: Interfaces/LOADE_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/OUTPUT4_MATRICES.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MATADD_FFF_Interface.o: Interfaces/MATADD_FFF_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MATADD_SSS_Interface.o: Interfaces/MATADD_SSS_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/SPARSE_ALG_ARRAYS.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MATADD_SSS_NTERM_Interface.o: Interfaces/MATADD_SSS_NTERM_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/DEBUG_PARAMETERS.o obj/SPARSE_ALG_ARRAYS.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MATERIAL_PROPS_2D_Interface.o: Interfaces/MATERIAL_PROPS_2D_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MATERIAL_PROPS_3D_Interface.o: Interfaces/MATERIAL_PROPS_3D_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MATGET_Interface.o: Interfaces/MATGET_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MATMULT_FFF_Interface.o: Interfaces/MATMULT_FFF_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MATMULT_FFF_T_Interface.o: Interfaces/MATMULT_FFF_T_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MATMULT_SFF_Interface.o: Interfaces/MATMULT_SFF_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/DEBUG_PARAMETERS.o obj/SPARSE_ALG_ARRAYS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MATMULT_SFS_Interface.o: Interfaces/MATMULT_SFS_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/DEBUG_PARAMETERS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MATMULT_SFS_NTERM_Interface.o: Interfaces/MATMULT_SFS_NTERM_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/PARAMS.o obj/SPARSE_ALG_ARRAYS.o obj/DEBUG_PARAMETERS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MATMULT_SSS_Interface.o: Interfaces/MATMULT_SSS_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/DEBUG_PARAMETERS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MATMULT_SSS_NTERM_Interface.o: Interfaces/MATMULT_SSS_NTERM_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/SPARSE_ALG_ARRAYS.o obj/DEBUG_PARAMETERS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MATPUT_Interface.o: Interfaces/MATPUT_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MATTRNSP_SS_Interface.o: Interfaces/MATTRNSP_SS_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/DEBUG_PARAMETERS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MAXREQ_OGEL_Interface.o: Interfaces/MAXREQ_OGEL_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/CC_OUTPUT_DESCRIBERS.o obj/LINK9_STUFF.o obj/DEBUG_PARAMETERS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MERGE_COL_VECS_Interface.o: Interfaces/MERGE_COL_VECS_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/DOF_TABLES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MERGE_KXX_Interface.o: Interfaces/MERGE_KXX_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/EIGEN_MATRICES_1.o obj/SPARSE_MATRICES.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MERGE_LTM_Interface.o: Interfaces/MERGE_LTM_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SPARSE_MATRICES.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MERGE_MAT_COLS_SSS_Interface.o: Interfaces/MERGE_MAT_COLS_SSS_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MERGE_MAT_ROWS_SSS_Interface.o: Interfaces/MERGE_MAT_ROWS_SSS_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/SPARSE_ALG_ARRAYS.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MERGE_MXX_Interface.o: Interfaces/MERGE_MXX_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/EIGEN_MATRICES_1.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MERGE_PHIXA_Interface.o: Interfaces/MERGE_PHIXA_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/EIGEN_MATRICES_1.o obj/SPARSE_MATRICES.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MGGC_MASS_MATRIX_Interface.o: Interfaces/MGGC_MASS_MATRIX_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/CONSTANTS_1.o obj/PARAMS.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/SPARSE_MATRICES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MGGS_MASS_MATRIX_Interface.o: Interfaces/MGGS_MASS_MATRIX_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/PARAMS.o obj/TIMDAT.o obj/DOF_TABLES.o obj/MODEL_STUF.o obj/SPARSE_MATRICES.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MIN4SH_Interface.o: Interfaces/MIN4SH_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MKCARD_Interface.o: Interfaces/MKCARD_Interface.f90 obj/PENTIUM_II_KIND.o obj/SCONTR.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MKJCARD_08_Interface.o: Interfaces/MKJCARD_08_Interface.f90 obj/PENTIUM_II_KIND.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MKJCARD_Interface.o: Interfaces/MKJCARD_Interface.f90 obj/PENTIUM_II_KIND.o obj/SCONTR.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MPC_PROC_Interface.o: Interfaces/MPC_PROC_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/DOF_TABLES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MYSTRAN_FILES_Interface.o: Interfaces/MYSTRAN_FILES_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/IOUNT1.o obj/IOUNT1.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/NET_CG_LOADS_LTM_Interface.o: Interfaces/NET_CG_LOADS_LTM_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/PARAMS.o obj/RIGID_BODY_DISP_MATS.o obj/MODEL_STUF.o obj/OUTPUT4_MATRICES.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/SCRATCH_MATRICES.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/NEXTC0_Interface.o: Interfaces/NEXTC0_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/NEXTC20_Interface.o: Interfaces/NEXTC20_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/NEXTC2_Interface.o: Interfaces/NEXTC2_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/NEXTC_Interface.o: Interfaces/NEXTC_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/OFP1_Interface.o: Interfaces/OFP1_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/DOF_TABLES.o obj/MODEL_STUF.o obj/LINK9_STUFF.o obj/COL_VECS.o obj/OUTPUT4_MATRICES.o obj/CC_OUTPUT_DESCRIBERS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/OFP2_Interface.o: Interfaces/OFP2_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/DOF_TABLES.o obj/EIGEN_MATRICES_1.o obj/MODEL_STUF.o obj/PARAMS.o obj/NONLINEAR_PARAMS.o obj/SPARSE_MATRICES.o obj/LINK9_STUFF.o obj/COL_VECS.o obj/DEBUG_PARAMETERS.o obj/OUTPUT4_MATRICES.o obj/CC_OUTPUT_DESCRIBERS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/OFP3_ELFE_1D_Interface.o: Interfaces/OFP3_ELFE_1D_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/FEMAP_ARRAYS.o obj/PARAMS.o obj/MODEL_STUF.o obj/LINK9_STUFF.o obj/OUTPUT4_MATRICES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/OFP3_ELFE_2D_Interface.o: Interfaces/OFP3_ELFE_2D_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/FEMAP_ARRAYS.o obj/PARAMS.o obj/MODEL_STUF.o obj/LINK9_STUFF.o obj/OUTPUT4_MATRICES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/OFP3_ELFN_Interface.o: Interfaces/OFP3_ELFN_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/PARAMS.o obj/MODEL_STUF.o obj/LINK9_STUFF.o obj/OUTPUT4_MATRICES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/OFP3_Interface.o: Interfaces/OFP3_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/LINK9_STUFF.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/OFP3_STRE_NO_PCOMP_Interface.o: Interfaces/OFP3_STRE_NO_PCOMP_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/FEMAP_ARRAYS.o obj/PARAMS.o obj/MODEL_STUF.o obj/CC_OUTPUT_DESCRIBERS.o obj/LINK9_STUFF.o obj/OUTPUT4_MATRICES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/OFP3_STRE_PCOMP_Interface.o: Interfaces/OFP3_STRE_PCOMP_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/FEMAP_ARRAYS.o obj/PARAMS.o obj/MODEL_STUF.o obj/LINK9_STUFF.o obj/OUTPUT4_MATRICES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/OFP3_STRN_NO_PCOMP_Interface.o: Interfaces/OFP3_STRN_NO_PCOMP_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/FEMAP_ARRAYS.o obj/PARAMS.o obj/MODEL_STUF.o obj/CC_OUTPUT_DESCRIBERS.o obj/LINK9_STUFF.o obj/OUTPUT4_MATRICES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/OFP3_STRN_PCOMP_Interface.o: Interfaces/OFP3_STRN_PCOMP_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/FEMAP_ARRAYS.o obj/PARAMS.o obj/MODEL_STUF.o obj/LINK9_STUFF.o obj/OUTPUT4_MATRICES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ONE_D_STRAIN_OUTPUTS_Interface.o: Interfaces/ONE_D_STRAIN_OUTPUTS_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/LINK9_STUFF.o obj/FEMAP_ARRAYS.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ONE_D_STRESS_OUTPUTS_Interface.o: Interfaces/ONE_D_STRESS_OUTPUTS_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/LINK9_STUFF.o obj/FEMAP_ARRAYS.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/OPEN_OUTFILES_Interface.o: Interfaces/OPEN_OUTFILES_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/TIMDAT.o
	$(F77) $(FLAGS) -c $< -o $@
obj/OPNERR_Interface.o: Interfaces/OPNERR_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ORDER_GAUSS_Interface.o: Interfaces/ORDER_GAUSS_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/CONSTANTS_GAUSS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ORDER_TETRA_Interface.o: Interfaces/ORDER_TETRA_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ORDER_TRIA_Interface.o: Interfaces/ORDER_TRIA_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o
	$(F77) $(FLAGS) -c $< -o $@
obj/OU4_PARTVEC_PROC_Interface.o: Interfaces/OU4_PARTVEC_PROC_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/CONSTANTS_1.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/SUBR_BEGEND_LEVELS.o obj/DOF_TABLES.o obj/OUTPUT4_MATRICES.o obj/MODEL_STUF.o obj/PARAMS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/OURDAT_Interface.o: Interfaces/OURDAT_Interface.f90 obj/PENTIUM_II_KIND.o obj/TIMDAT.o
	$(F77) $(FLAGS) -c $< -o $@
obj/OURTIM_Interface.o: Interfaces/OURTIM_Interface.f90 obj/PENTIUM_II_KIND.o obj/TIMDAT.o
	$(F77) $(FLAGS) -c $< -o $@
obj/OUTA_HERE_Interface.o: Interfaces/OUTA_HERE_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/OUTPUT4_MATRIX_MSGS_Interface.o: Interfaces/OUTPUT4_MATRIX_MSGS_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/OUTPUT4_MATRICES.o obj/PARAMS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/OUTPUT4_PROC_Interface.o: Interfaces/OUTPUT4_PROC_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/SCONTR.o obj/MODEL_STUF.o obj/PARAMS.o obj/EIGEN_MATRICES_1.o obj/FULL_MATRICES.o obj/MODEL_STUF.o obj/RIGID_BODY_DISP_MATS.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/SCRATCH_MATRICES.o obj/OUTPUT4_MATRICES.o obj/TIMDAT.o obj/RIGID_BODY_DISP_MATS.o obj/EIGEN_MATRICES_1.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/FULL_MATRICES.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/PARAM_CORDS_ACT_CORDS_Interface.o: Interfaces/PARAM_CORDS_ACT_CORDS_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/PARSE_CHAR_STRING_Interface.o: Interfaces/PARSE_CHAR_STRING_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/PARTITION_FF_Interface.o: Interfaces/PARTITION_FF_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/DEBUG_PARAMETERS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/PARTITION_SS_Interface.o: Interfaces/PARTITION_SS_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/DEBUG_PARAMETERS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/PARTITION_SS_NTERM_Interface.o: Interfaces/PARTITION_SS_NTERM_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SPARSE_ALG_ARRAYS.o obj/DEBUG_PARAMETERS.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/PARTITION_VEC_Interface.o: Interfaces/PARTITION_VEC_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/DOF_TABLES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/PENTA_Interface.o: Interfaces/PENTA_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/SUBR_BEGEND_LEVELS.o obj/PARAMS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/PINFLG_Interface.o: Interfaces/PINFLG_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/PLANE_COORD_TRANS_21_Interface.o: Interfaces/PLANE_COORD_TRANS_21_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/POLYNOM_FIT_STRE_STRN_Interface.o: Interfaces/POLYNOM_FIT_STRE_STRN_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/MODEL_STUF.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/POLY_FAILURE_INDEX_Interface.o: Interfaces/POLY_FAILURE_INDEX_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/MACHINE_PARAMS.o obj/DEBUG_PARAMETERS.o obj/PARAMS.o obj/MODEL_STUF.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/PRESSURE_DATA_PROC_Interface.o: Interfaces/PRESSURE_DATA_PROC_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/IOUNT1.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/PRINCIPAL_2D_Interface.o: Interfaces/PRINCIPAL_2D_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/PRINCIPAL_3D_Interface.o: Interfaces/PRINCIPAL_3D_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/PRINT_CONSTANTS_1_Interface.o: Interfaces/PRINT_CONSTANTS_1_Interface.f90 obj/PENTIUM_II_KIND.o obj/CONSTANTS_1.o obj/IOUNT1.o obj/SCONTR.o
	$(F77) $(FLAGS) -c $< -o $@
obj/PRINT_ORDER_Interface.o: Interfaces/PRINT_ORDER_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o
	$(F77) $(FLAGS) -c $< -o $@
obj/PROCESS_INCLUDE_FILES_Interface.o: Interfaces/PROCESS_INCLUDE_FILES_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/PROJ_VEC_ONTO_PLANE_Interface.o: Interfaces/PROJ_VEC_ONTO_PLANE_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/PRT_MATS_ON_RESTART_Interface.o: Interfaces/PRT_MATS_ON_RESTART_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/IOUNT1.o obj/IOUNT1.o obj/IOUNT1.o obj/IOUNT1.o obj/SCONTR.o obj/SCONTR.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/COL_VECS.o obj/SPARSE_MATRICES.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/QDEL1_Interface.o: Interfaces/QDEL1_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/PARAMS.o obj/MODEL_STUF.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/QMEM1_Interface.o: Interfaces/QMEM1_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/DEBUG_PARAMETERS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/QPLT1_Interface.o: Interfaces/QPLT1_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/QPLT2_Interface.o: Interfaces/QPLT2_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/MODEL_STUF.o obj/DEBUG_PARAMETERS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/QPLT3_Interface.o: Interfaces/QPLT3_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/MACHINE_PARAMS.o obj/MODEL_STUF.o obj/DEBUG_PARAMETERS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/QSHEAR_Interface.o: Interfaces/QSHEAR_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/DEBUG_PARAMETERS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/R8FLD_Interface.o: Interfaces/R8FLD_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/CONSTANTS_1.o
	$(F77) $(FLAGS) -c $< -o $@
obj/RBE2_PROC_Interface.o: Interfaces/RBE2_PROC_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/DOF_TABLES.o obj/MODEL_STUF.o obj/DEBUG_PARAMETERS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/RBE3_PROC_Interface.o: Interfaces/RBE3_PROC_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/DOF_TABLES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/RB_DISP_MATRIX_PROC_Interface.o: Interfaces/RB_DISP_MATRIX_PROC_Interface.f90 obj/PENTIUM_II_KIND.o obj/CONSTANTS_1.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/DOF_TABLES.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/RIGID_BODY_DISP_MATS.o obj/DEBUG_PARAMETERS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/RDOF_Interface.o: Interfaces/RDOF_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/READERR_Interface.o: Interfaces/READERR_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/READ_CHK_Interface.o: Interfaces/READ_CHK_Interface.f90 obj/PENTIUM_II_KIND.o
	$(F77) $(FLAGS) -c $< -o $@
obj/READ_CL_Interface.o: Interfaces/READ_CL_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o
	$(F77) $(FLAGS) -c $< -o $@
obj/READ_DOF_TABLES_Interface.o: Interfaces/READ_DOF_TABLES_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/DOF_TABLES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/READ_IN4_FULL_MAT_Interface.o: Interfaces/READ_IN4_FULL_MAT_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/READ_INCLUDE_FILNAM_Interface.o: Interfaces/READ_INCLUDE_FILNAM_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/READ_INI_Interface.o: Interfaces/READ_INI_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/IOUNT1.o obj/IOUNT1.o obj/SCONTR.o
	$(F77) $(FLAGS) -c $< -o $@
obj/READ_INPUT_FILE_NAME_Interface.o: Interfaces/READ_INPUT_FILE_NAME_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o
	$(F77) $(FLAGS) -c $< -o $@
obj/READ_L1A_Interface.o: Interfaces/READ_L1A_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/IOUNT1.o obj/IOUNT1.o obj/IOUNT1.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/DEBUG_PARAMETERS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/READ_L1M_Interface.o: Interfaces/READ_L1M_Interface.f90 obj/PENTIUM_II_KIND.o obj/SCONTR.o obj/IOUNT1.o obj/TIMDAT.o obj/EIGEN_MATRICES_1.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/READ_L1Z_Interface.o: Interfaces/READ_L1Z_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/MODEL_STUF.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/READ_MATRIX_1_Interface.o: Interfaces/READ_MATRIX_1_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/READ_MATRIX_2_Interface.o: Interfaces/READ_MATRIX_2_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/READ_XTIME_Interface.o: Interfaces/READ_XTIME_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/REAL_DATA_TO_C8FLD_Interface.o: Interfaces/REAL_DATA_TO_C8FLD_Interface.f90 obj/PENTIUM_II_KIND.o
	$(F77) $(FLAGS) -c $< -o $@
obj/REDUCE_A_LR_Interface.o: Interfaces/REDUCE_A_LR_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/DOF_TABLES.o obj/RIGID_BODY_DISP_MATS.o obj/PARAMS.o obj/NONLINEAR_PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/OUTPUT4_MATRICES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/REDUCE_F_AO_Interface.o: Interfaces/REDUCE_F_AO_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/NONLINEAR_PARAMS.o obj/TIMDAT.o obj/DOF_TABLES.o obj/RIGID_BODY_DISP_MATS.o obj/SUBR_BEGEND_LEVELS.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/SCRATCH_MATRICES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/REDUCE_G_NM_Interface.o: Interfaces/REDUCE_G_NM_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/NONLINEAR_PARAMS.o obj/DOF_TABLES.o obj/MODEL_STUF.o obj/RIGID_BODY_DISP_MATS.o obj/SUBR_BEGEND_LEVELS.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/OUTPUT4_MATRICES.o obj/SCRATCH_MATRICES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/REDUCE_KAAD_TO_KLLD_Interface.o: Interfaces/REDUCE_KAAD_TO_KLLD_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/SPARSE_MATRICES.o obj/SCRATCH_MATRICES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/REDUCE_KAA_TO_KLL_Interface.o: Interfaces/REDUCE_KAA_TO_KLL_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/SPARSE_MATRICES.o obj/SCRATCH_MATRICES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/REDUCE_KFFD_TO_KAAD_Interface.o: Interfaces/REDUCE_KFFD_TO_KAAD_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/SCRATCH_MATRICES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/REDUCE_KFF_TO_KAA_Interface.o: Interfaces/REDUCE_KFF_TO_KAA_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/FULL_MATRICES.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/SCRATCH_MATRICES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/REDUCE_KGGD_TO_KNND_Interface.o: Interfaces/REDUCE_KGGD_TO_KNND_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/SCRATCH_MATRICES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/REDUCE_KGG_TO_KNN_Interface.o: Interfaces/REDUCE_KGG_TO_KNN_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/FULL_MATRICES.o obj/SCRATCH_MATRICES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/REDUCE_KNND_TO_KFFD_Interface.o: Interfaces/REDUCE_KNND_TO_KFFD_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/SCRATCH_MATRICES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/REDUCE_KNN_TO_KFF_Interface.o: Interfaces/REDUCE_KNN_TO_KFF_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/SCRATCH_MATRICES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/REDUCE_MAA_TO_MLL_Interface.o: Interfaces/REDUCE_MAA_TO_MLL_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/SPARSE_MATRICES.o obj/SCRATCH_MATRICES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/REDUCE_MFF_TO_MAA_Interface.o: Interfaces/REDUCE_MFF_TO_MAA_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/FULL_MATRICES.o obj/SCRATCH_MATRICES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/REDUCE_MGG_TO_MNN_Interface.o: Interfaces/REDUCE_MGG_TO_MNN_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/FULL_MATRICES.o obj/SCRATCH_MATRICES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/REDUCE_MNN_TO_MFF_Interface.o: Interfaces/REDUCE_MNN_TO_MFF_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/SCRATCH_MATRICES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/REDUCE_N_FS_Interface.o: Interfaces/REDUCE_N_FS_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/DOF_TABLES.o obj/RIGID_BODY_DISP_MATS.o obj/PARAMS.o obj/NONLINEAR_PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/COL_VECS.o obj/DEBUG_PARAMETERS.o obj/SCRATCH_MATRICES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/REDUCE_PA_TO_PL_Interface.o: Interfaces/REDUCE_PA_TO_PL_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/REDUCE_PF_TO_PA_Interface.o: Interfaces/REDUCE_PF_TO_PA_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/FULL_MATRICES.o obj/SCRATCH_MATRICES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/REDUCE_PG_TO_PN_Interface.o: Interfaces/REDUCE_PG_TO_PN_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/FULL_MATRICES.o obj/SCRATCH_MATRICES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/REDUCE_PN_TO_PF_Interface.o: Interfaces/REDUCE_PN_TO_PF_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/COL_VECS.o obj/FULL_MATRICES.o obj/DEBUG_PARAMETERS.o obj/SCRATCH_MATRICES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/RENORM_Interface.o: Interfaces/RENORM_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/COL_VECS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/RENORM_ON_MASS_Interface.o: Interfaces/RENORM_ON_MASS_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/EIGEN_MATRICES_1.o obj/MODEL_STUF.o obj/DEBUG_PARAMETERS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/REPLACE_TABS_W_BLANKS_Interface.o: Interfaces/REPLACE_TABS_W_BLANKS_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/RESTART_DATA_FOR_L3_Interface.o: Interfaces/RESTART_DATA_FOR_L3_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/IOUNT1.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SPARSE_MATRICES.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/RFORCE_PROC_Interface.o: Interfaces/RFORCE_PROC_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/DOF_TABLES.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/RIGID_BODY_DISP_MAT_Interface.o: Interfaces/RIGID_BODY_DISP_MAT_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/RIGID_ELEM_PROC_Interface.o: Interfaces/RIGID_ELEM_PROC_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ROD1_Interface.o: Interfaces/ROD1_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ROD_MARGIN_Interface.o: Interfaces/ROD_MARGIN_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ROT_AXES_MATL_TO_LOC_Interface.o: Interfaces/ROT_AXES_MATL_TO_LOC_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ROT_COMP_ELEM_AXES_Interface.o: Interfaces/ROT_COMP_ELEM_AXES_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/MODEL_STUF.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ROW_AT_COLJ_BEGEND_Interface.o: Interfaces/ROW_AT_COLJ_BEGEND_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/RSPLINE_PROC_Interface.o: Interfaces/RSPLINE_PROC_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/DOF_TABLES.o obj/MODEL_STUF.o obj/PARAMS.o obj/DEBUG_PARAMETERS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/RW_INCLUDE_FILES_Interface.o: Interfaces/RW_INCLUDE_FILES_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SEQ_PROC_Interface.o: Interfaces/SEQ_PROC_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/IOUNT1.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/DEBUG_PARAMETERS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SET_FILE_CLOSE_STAT_Interface.o: Interfaces/SET_FILE_CLOSE_STAT_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SET_SPARSE_MAT_SYM_Interface.o: Interfaces/SET_SPARSE_MAT_SYM_Interface.f90 obj/IOUNT1.o obj/PARAMS.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SHELL_ABD_MATRICES_Interface.o: Interfaces/SHELL_ABD_MATRICES_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/PARAMS.o obj/MODEL_STUF.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SHELL_ENGR_FORCE_OGEL_Interface.o: Interfaces/SHELL_ENGR_FORCE_OGEL_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/LINK9_STUFF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SHELL_STRAIN_OUTPUTS_Interface.o: Interfaces/SHELL_STRAIN_OUTPUTS_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/CC_OUTPUT_DESCRIBERS.o obj/LINK9_STUFF.o obj/FEMAP_ARRAYS.o obj/PARAMS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SHELL_STRESS_OUTPUTS_Interface.o: Interfaces/SHELL_STRESS_OUTPUTS_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/CC_OUTPUT_DESCRIBERS.o obj/LINK9_STUFF.o obj/FEMAP_ARRAYS.o obj/PARAMS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SHP2DQ_Interface.o: Interfaces/SHP2DQ_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SHP3DH_Interface.o: Interfaces/SHP3DH_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SHP3DP_Interface.o: Interfaces/SHP3DP_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SHP3DT_Interface.o: Interfaces/SHP3DT_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SLOAD_PROC_Interface.o: Interfaces/SLOAD_PROC_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/DOF_TABLES.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SOLID_STRAIN_OUTPUTS_Interface.o: Interfaces/SOLID_STRAIN_OUTPUTS_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/CC_OUTPUT_DESCRIBERS.o obj/LINK9_STUFF.o obj/FEMAP_ARRAYS.o obj/PARAMS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SOLID_STRESS_OUTPUTS_Interface.o: Interfaces/SOLID_STRESS_OUTPUTS_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/CC_OUTPUT_DESCRIBERS.o obj/LINK9_STUFF.o obj/FEMAP_ARRAYS.o obj/PARAMS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SOLVE6_SETUP_Interface.o: Interfaces/SOLVE6_SETUP_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/SPARSE_MATRICES.o obj/LAPACK_LIN_EQN_DPB.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SOLVE_DLR_Interface.o: Interfaces/SOLVE_DLR_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/SPARSE_MATRICES.o obj/LAPACK_LIN_EQN_DPB.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SOLVE_GMN_Interface.o: Interfaces/SOLVE_GMN_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/DEBUG_PARAMETERS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SOLVE_GOA_Interface.o: Interfaces/SOLVE_GOA_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/SPARSE_MATRICES.o obj/DEBUG_PARAMETERS.o obj/LAPACK_LIN_EQN_DPB.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SOLVE_PHIZL1_Interface.o: Interfaces/SOLVE_PHIZL1_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/SCRATCH_MATRICES.o obj/SPARSE_MATRICES.o obj/LAPACK_LIN_EQN_DPB.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SOLVE_SHELL_ALP_Interface.o: Interfaces/SOLVE_SHELL_ALP_Interface.f90 obj/PENTIUM_II_KIND.o obj/SCONTR.o obj/PARAMS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SOLVE_UO0_Interface.o: Interfaces/SOLVE_UO0_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/SPARSE_MATRICES.o obj/COL_VECS.o obj/LAPACK_LIN_EQN_DPB.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SORTLEN_Interface.o: Interfaces/SORTLEN_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/CONSTANTS_1.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SORT_GRID_RGRID_Interface.o: Interfaces/SORT_GRID_RGRID_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SORT_INT1_Interface.o: Interfaces/SORT_INT1_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SORT_INT1_REAL1_Interface.o: Interfaces/SORT_INT1_REAL1_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SORT_INT1_REAL3_Interface.o: Interfaces/SORT_INT1_REAL3_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SORT_INT2_Interface.o: Interfaces/SORT_INT2_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SORT_INT2_REAL1_Interface.o: Interfaces/SORT_INT2_REAL1_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SORT_INT3_CHAR2_Interface.o: Interfaces/SORT_INT3_CHAR2_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SORT_INT3_Interface.o: Interfaces/SORT_INT3_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SORT_REAL1_INT1_Interface.o: Interfaces/SORT_REAL1_INT1_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SORT_TDOF_Interface.o: Interfaces/SORT_TDOF_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SPARSE_CRS_SPARSE_CCS_Interface.o: Interfaces/SPARSE_CRS_SPARSE_CCS_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/DEBUG_PARAMETERS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SPARSE_CRS_TERM_COUNT_Interface.o: Interfaces/SPARSE_CRS_TERM_COUNT_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SPARSE_CRS_TO_FULL_Interface.o: Interfaces/SPARSE_CRS_TO_FULL_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SPARSE_KGGD_Interface.o: Interfaces/SPARSE_KGGD_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/NONLINEAR_PARAMS.o obj/MODEL_STUF.o obj/DOF_TABLES.o obj/STF_ARRAYS.o obj/SPARSE_MATRICES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SPARSE_KGG_Interface.o: Interfaces/SPARSE_KGG_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/NONLINEAR_PARAMS.o obj/MODEL_STUF.o obj/DOF_TABLES.o obj/STF_ARRAYS.o obj/SPARSE_MATRICES.o obj/DEBUG_PARAMETERS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SPARSE_MAT_DIAG_ZEROS_Interface.o: Interfaces/SPARSE_MAT_DIAG_ZEROS_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SPARSE_MGG_Interface.o: Interfaces/SPARSE_MGG_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/DEBUG_PARAMETERS.o obj/CONSTANTS_1.o obj/DOF_TABLES.o obj/MODEL_STUF.o obj/PARAMS.o obj/EMS_ARRAYS.o obj/SPARSE_MATRICES.o obj/SCRATCH_MATRICES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SPARSE_PG_Interface.o: Interfaces/SPARSE_PG_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/PARAMS.o obj/NONLINEAR_PARAMS.o obj/MODEL_STUF.o obj/SPARSE_MATRICES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SPARSE_RMG_Interface.o: Interfaces/SPARSE_RMG_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/PARAMS.o obj/SPARSE_MATRICES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/STIFF_MAT_EQUIL_CHK_Interface.o: Interfaces/STIFF_MAT_EQUIL_CHK_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/DOF_TABLES.o obj/DEBUG_PARAMETERS.o obj/LAPACK_DPB_MATRICES.o obj/LAPACK_BLAS_AUX.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/DEBUG_PARAMETERS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/STMERR_Interface.o: Interfaces/STMERR_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/STOKEN_Interface.o: Interfaces/STOKEN_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/DEBUG_PARAMETERS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/STR_TENSOR_TRANSFORM_Interface.o: Interfaces/STR_TENSOR_TRANSFORM_Interface.f90 obj/PENTIUM_II_KIND.o obj/CONSTANTS_1.o obj/SCONTR.o obj/IOUNT1.o obj/TIMDAT.o obj/MODEL_STUF.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SUBCASE_PROC_Interface.o: Interfaces/SUBCASE_PROC_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SURFACE_FIT_Interface.o: Interfaces/SURFACE_FIT_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/LSQ_MYSTRAN.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SUSER1_Interface.o: Interfaces/SUSER1_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SYM_MAT_DECOMP_LAPACK_Interface.o: Interfaces/SYM_MAT_DECOMP_LAPACK_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/PARAMS.o obj/LAPACK_DPB_MATRICES.o obj/DEBUG_PARAMETERS.o obj/MACHINE_PARAMS.o obj/LAPACK_LIN_EQN_DPB.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/TDOF_COL_NUM_Interface.o: Interfaces/TDOF_COL_NUM_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/TDOF_PROC_Interface.o: Interfaces/TDOF_PROC_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/DOF_TABLES.o obj/DEBUG_PARAMETERS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/TEMPERATURE_DATA_PROC_Interface.o: Interfaces/TEMPERATURE_DATA_PROC_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/IOUNT1.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/DEBUG_PARAMETERS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/TETRA_Interface.o: Interfaces/TETRA_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/SUBR_BEGEND_LEVELS.o obj/PARAMS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/TIME_INIT_Interface.o: Interfaces/TIME_INIT_Interface.f90 obj/TIMDAT.o
	$(F77) $(FLAGS) -c $< -o $@
obj/TMEM1_Interface.o: Interfaces/TMEM1_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/TOKCHK_Interface.o: Interfaces/TOKCHK_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o
	$(F77) $(FLAGS) -c $< -o $@
obj/TPLT1_Interface.o: Interfaces/TPLT1_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/TPLT2_Interface.o: Interfaces/TPLT2_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/DEBUG_PARAMETERS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/TRANSFORM_NODE_FORCES_Interface.o: Interfaces/TRANSFORM_NODE_FORCES_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/TREL1_Interface.o: Interfaces/TREL1_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/MODEL_STUF.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/TSET_PROC_FOR_MPCS_Interface.o: Interfaces/TSET_PROC_FOR_MPCS_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/DOF_TABLES.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/TSET_PROC_FOR_OMITS_Interface.o: Interfaces/TSET_PROC_FOR_OMITS_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/DOF_TABLES.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/TSET_PROC_FOR_RIGELS_Interface.o: Interfaces/TSET_PROC_FOR_RIGELS_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/DOF_TABLES.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/TSET_PROC_FOR_SPCS_Interface.o: Interfaces/TSET_PROC_FOR_SPCS_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/PARAMS.o obj/DOF_TABLES.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/TSET_PROC_FOR_SUPORTS_Interface.o: Interfaces/TSET_PROC_FOR_SUPORTS_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/PARAMS.o obj/DOF_TABLES.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/TSET_PROC_Interface.o: Interfaces/TSET_PROC_Interface.f90
	$(F77) $(FLAGS) -c $< -o $@
obj/USERIN_Interface.o: Interfaces/USERIN_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/DOF_TABLES.o obj/PARAMS.o obj/INPUTT4_MATRICES.o obj/RIGID_BODY_DISP_MATS.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/USET_PROC_Interface.o: Interfaces/USET_PROC_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/PARAMS.o obj/DOF_TABLES.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/VECINORM_Interface.o: Interfaces/VECINORM_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o
	$(F77) $(FLAGS) -c $< -o $@
obj/VECTOR_NORM_Interface.o: Interfaces/VECTOR_NORM_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_ALLOC_MEM_TABLE_Interface.o: Interfaces/WRITE_ALLOC_MEM_TABLE_Interface.f90 obj/PENTIUM_II_KIND.o obj/SCONTR.o obj/IOUNT1.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/ALLOCATED_ARRAY_DATA.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_BAR_Interface.o: Interfaces/WRITE_BAR_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/LINK9_STUFF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_DOF_TABLES_Interface.o: Interfaces/WRITE_DOF_TABLES_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/DOF_TABLES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_EDAT_Interface.o: Interfaces/WRITE_EDAT_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/MODEL_STUF.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_ELEM_ENGR_FORCE_Interface.o: Interfaces/WRITE_ELEM_ENGR_FORCE_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/NONLINEAR_PARAMS.o obj/LINK9_STUFF.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_ELEM_NODE_FORCE_Interface.o: Interfaces/WRITE_ELEM_NODE_FORCE_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/SUBR_BEGEND_LEVELS.o obj/LINK9_STUFF.o obj/MODEL_STUF.o obj/MACHINE_PARAMS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_ELEM_STRAINS_Interface.o: Interfaces/WRITE_ELEM_STRAINS_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/NONLINEAR_PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/LINK9_STUFF.o obj/MODEL_STUF.o obj/CC_OUTPUT_DESCRIBERS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_ELEM_STRESSES_Interface.o: Interfaces/WRITE_ELEM_STRESSES_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/NONLINEAR_PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/LINK9_STUFF.o obj/MODEL_STUF.o obj/CC_OUTPUT_DESCRIBERS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_ELM_OT4_Interface.o: Interfaces/WRITE_ELM_OT4_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CC_OUTPUT_DESCRIBERS.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_ENF_TO_L1O_Interface.o: Interfaces/WRITE_ENF_TO_L1O_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/DOF_TABLES.o obj/MODEL_STUF.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_EOFIL_Interface.o: Interfaces/WRITE_EOFIL_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/PARAMS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_FEMAP_ELFO_VECS_Interface.o: Interfaces/WRITE_FEMAP_ELFO_VECS_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/FEMAP_ARRAYS.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_FEMAP_GRID_VECS_Interface.o: Interfaces/WRITE_FEMAP_GRID_VECS_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_FEMAP_STRE_VECS_Interface.o: Interfaces/WRITE_FEMAP_STRE_VECS_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CC_OUTPUT_DESCRIBERS.o obj/FEMAP_ARRAYS.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_FEMAP_STRN_VECS_Interface.o: Interfaces/WRITE_FEMAP_STRN_VECS_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CC_OUTPUT_DESCRIBERS.o obj/FEMAP_ARRAYS.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_FILNAM_Interface.o: Interfaces/WRITE_FILNAM_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_GRD_OT4_Interface.o: Interfaces/WRITE_GRD_OT4_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_GRD_PCH_OUTPUTS_Interface.o: Interfaces/WRITE_GRD_PCH_OUTPUTS_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/NONLINEAR_PARAMS.o obj/LINK9_STUFF.o obj/MODEL_STUF.o obj/EIGEN_MATRICES_1.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_GRD_PRT_OUTPUTS_Interface.o: Interfaces/WRITE_GRD_PRT_OUTPUTS_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/NONLINEAR_PARAMS.o obj/LINK9_STUFF.o obj/MODEL_STUF.o obj/MACHINE_PARAMS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_GRID_COORDS_Interface.o: Interfaces/WRITE_GRID_COORDS_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_INTEGER_VEC_Interface.o: Interfaces/WRITE_INTEGER_VEC_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_L1A_Interface.o: Interfaces/WRITE_L1A_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/IOUNT1.o obj/IOUNT1.o obj/IOUNT1.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/PARAMS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_L1M_Interface.o: Interfaces/WRITE_L1M_Interface.f90 obj/PENTIUM_II_KIND.o obj/SCONTR.o obj/IOUNT1.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/EIGEN_MATRICES_1.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_L1Z_Interface.o: Interfaces/WRITE_L1Z_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/MODEL_STUF.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_MATRIX_1_Interface.o: Interfaces/WRITE_MATRIX_1_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_MATRIX_BY_COLS_Interface.o: Interfaces/WRITE_MATRIX_BY_COLS_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_MATRIX_BY_ROWS_Interface.o: Interfaces/WRITE_MATRIX_BY_ROWS_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_MEFFMASS_Interface.o: Interfaces/WRITE_MEFFMASS_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/EIGEN_MATRICES_1.o obj/MODEL_STUF.o obj/PARAMS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_MEM_SUM_TO_F04_Interface.o: Interfaces/WRITE_MEM_SUM_TO_F04_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/DEBUG_PARAMETERS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_MPFACTOR_Interface.o: Interfaces/WRITE_MPFACTOR_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/EIGEN_MATRICES_1.o obj/MODEL_STUF.o obj/PARAMS.o obj/DOF_TABLES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_OU4_FULL_MAT_Interface.o: Interfaces/WRITE_OU4_FULL_MAT_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_OU4_SPARSE_MAT_Interface.o: Interfaces/WRITE_OU4_SPARSE_MAT_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/PARAMS.o obj/SCRATCH_MATRICES.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_PARTNd_MAT_HDRS_Interface.o: Interfaces/WRITE_PARTNd_MAT_HDRS_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/DOF_TABLES.o obj/OUTPUT4_MATRICES.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_PCOMP_EQUIV_Interface.o: Interfaces/WRITE_PCOMP_EQUIV_Interface.f90 obj/PENTIUM_II_KIND.o obj/CONSTANTS_1.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/MODEL_STUF.o obj/TIMDAT.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_PLY_STRAINS_Interface.o: Interfaces/WRITE_PLY_STRAINS_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/NONLINEAR_PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/LINK9_STUFF.o obj/MODEL_STUF.o obj/CC_OUTPUT_DESCRIBERS.o obj/MACHINE_PARAMS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_PLY_STRESSES_Interface.o: Interfaces/WRITE_PLY_STRESSES_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/NONLINEAR_PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/LINK9_STUFF.o obj/MODEL_STUF.o obj/CC_OUTPUT_DESCRIBERS.o obj/MACHINE_PARAMS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_ROD_Interface.o: Interfaces/WRITE_ROD_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/LINK9_STUFF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_SPARSE_CRS_Interface.o: Interfaces/WRITE_SPARSE_CRS_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_TDOF_Interface.o: Interfaces/WRITE_TDOF_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/DOF_TABLES.o obj/PARAMS.o obj/MODEL_STUF.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_TSET_Interface.o: Interfaces/WRITE_TSET_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/MODEL_STUF.o obj/DOF_TABLES.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_USERIN_BD_CARDS_Interface.o: Interfaces/WRITE_USERIN_BD_CARDS_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/DOF_TABLES.o obj/PARAMS.o obj/MODEL_STUF.o obj/OUTPUT4_MATRICES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_USETSTR_Interface.o: Interfaces/WRITE_USETSTR_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/DOF_TABLES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_USET_Interface.o: Interfaces/WRITE_USET_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/MODEL_STUF.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/DOF_TABLES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_VECTOR_Interface.o: Interfaces/WRITE_VECTOR_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRT_REAL_TO_CHAR_VAR_Interface.o: Interfaces/WRT_REAL_TO_CHAR_VAR_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o
	$(F77) $(FLAGS) -c $< -o $@
obj/YS_ARRAY_Interface.o: Interfaces/YS_ARRAY_Interface.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/IOUNT1.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/DOF_TABLES.o obj/MODEL_STUF.o obj/COL_VECS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CSHIFT.o: LK1/L1A/CSHIFT.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CSHIFT_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/EC_DEBUG.o: LK1/L1A/EC_DEBUG.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/DEBUG_PARAMETERS.o obj/EC_DEBUG_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/EC_IN4FIL.o: LK1/L1A/EC_IN4FIL.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/EC_IN4FIL_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/EC_OUTPUT4.o: LK1/L1A/EC_OUTPUT4.f90 obj/PENTIUM_II_KIND.o obj/SCONTR.o obj/SUBR_BEGEND_LEVELS.o obj/IOUNT1.o obj/DEBUG_PARAMETERS.o obj/OUTPUT4_MATRICES.o obj/TIMDAT.o obj/EC_OUTPUT4_USE_IFs.o obj/PENTIUM_II_KIND.o obj/PENTIUM_II_KIND.o
	$(F77) $(FLAGS) -c $< -o $@
obj/EC_PARTN.o: LK1/L1A/EC_PARTN.f90 obj/PENTIUM_II_KIND.o obj/SCONTR.o obj/SUBR_BEGEND_LEVELS.o obj/IOUNT1.o obj/DEBUG_PARAMETERS.o obj/OUTPUT4_MATRICES.o obj/TIMDAT.o obj/EC_PARTN_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ELEPRO.o: LK1/L1A/ELEPRO.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/ELEPRO_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/FFIELD.o: LK1/L1A/FFIELD.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/FFIELD_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/FFIELD2.o: LK1/L1A/FFIELD2.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/FFIELD2_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/IS_THIS_A_RESTART.o: LK1/L1A/IS_THIS_A_RESTART.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/IS_THIS_A_RESTART_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/LOADB.o: LK1/L1A/LOADB.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/PARAMS.o obj/OUTPUT4_MATRICES.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/LOADB_USE_IFs.o obj/SCONTR.o obj/MODEL_STUF.o obj/SCONTR.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/LOADB0.o: LK1/L1A/LOADB0.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/PARAMS.o obj/LOADB0_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/LOADB_RESTART.o: LK1/L1A/LOADB_RESTART.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/DEBUG_PARAMETERS.o obj/SUBR_BEGEND_LEVELS.o obj/LOADB_RESTART_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/LOADC.o: LK1/L1A/LOADC.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/CC_OUTPUT_DESCRIBERS.o obj/LOADC_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/LOADC0.o: LK1/L1A/LOADC0.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/LOADC0_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/LOADE.o: LK1/L1A/LOADE.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/OUTPUT4_MATRICES.o obj/SUBR_BEGEND_LEVELS.o obj/LOADE_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/LOADE0.o: LK1/L1A/LOADE0.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/LOADE0_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/READ_INCLUDE_FILNAM.o: LK1/L1A/READ_INCLUDE_FILNAM.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/SUBR_BEGEND_LEVELS.o obj/READ_INCLUDE_FILNAM_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/REPLACE_TABS_W_BLANKS.o: LK1/L1A/REPLACE_TABS_W_BLANKS.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/REPLACE_TABS_W_BLANKS_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/RW_INCLUDE_FILES.o: LK1/L1A/RW_INCLUDE_FILES.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/RW_INCLUDE_FILES_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_ASET.o: LK1/L1A-BD/BD_ASET.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/DOF_TABLES.o obj/BD_ASET_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_ASET1.o: LK1/L1A-BD/BD_ASET1.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/DOF_TABLES.o obj/BD_ASET1_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_BAROR.o: LK1/L1A-BD/BD_BAROR.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/BD_BAROR_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_BAROR0.o: LK1/L1A-BD/BD_BAROR0.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/BD_BAROR0_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_BEAMOR.o: LK1/L1A-BD/BD_BEAMOR.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/BD_BEAMOR_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_BEAMOR0.o: LK1/L1A-BD/BD_BEAMOR0.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/BD_BEAMOR0_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CBAR.o: LK1/L1A-BD/BD_CBAR.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/MODEL_STUF.o obj/BD_CBAR_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CBAR0.o: LK1/L1A-BD/BD_CBAR0.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/BD_CBAR0_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CBUSH.o: LK1/L1A-BD/BD_CBUSH.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/MODEL_STUF.o obj/BD_CBUSH_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CBUSH0.o: LK1/L1A-BD/BD_CBUSH0.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/BD_CBUSH0_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CELAS1.o: LK1/L1A-BD/BD_CELAS1.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/BD_CELAS1_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CELAS2.o: LK1/L1A-BD/BD_CELAS2.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/BD_CELAS2_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CELAS3.o: LK1/L1A-BD/BD_CELAS3.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/BD_CELAS3_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CELAS4.o: LK1/L1A-BD/BD_CELAS4.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/BD_CELAS4_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CHEXA.o: LK1/L1A-BD/BD_CHEXA.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/BD_CHEXA_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CHEXA0.o: LK1/L1A-BD/BD_CHEXA0.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/BD_CHEXA0_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CMASS1.o: LK1/L1A-BD/BD_CMASS1.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/BD_CMASS1_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CMASS2.o: LK1/L1A-BD/BD_CMASS2.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/BD_CMASS2_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CMASS3.o: LK1/L1A-BD/BD_CMASS3.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/BD_CMASS3_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CMASS4.o: LK1/L1A-BD/BD_CMASS4.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/BD_CMASS4_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CONM2.o: LK1/L1A-BD/BD_CONM2.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/MODEL_STUF.o obj/BD_CONM2_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CONROD.o: LK1/L1A-BD/BD_CONROD.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/BD_CONROD_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CORD.o: LK1/L1A-BD/BD_CORD.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/BD_CORD_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CPENTA.o: LK1/L1A-BD/BD_CPENTA.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/BD_CPENTA_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CPENTA0.o: LK1/L1A-BD/BD_CPENTA0.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/BD_CPENTA0_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CQUAD.o: LK1/L1A-BD/BD_CQUAD.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/BD_CQUAD_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CQUAD0.o: LK1/L1A-BD/BD_CQUAD0.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/BD_CQUAD0_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CROD.o: LK1/L1A-BD/BD_CROD.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/BD_CROD_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CSHEAR.o: LK1/L1A-BD/BD_CSHEAR.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/BD_CSHEAR_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CTETRA.o: LK1/L1A-BD/BD_CTETRA.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/BD_CTETRA_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CTETRA0.o: LK1/L1A-BD/BD_CTETRA0.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/BD_CTETRA0_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CTRIA.o: LK1/L1A-BD/BD_CTRIA.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/BD_CTRIA_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CTRIA0.o: LK1/L1A-BD/BD_CTRIA0.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/BD_CTRIA0_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CUSER1.o: LK1/L1A-BD/BD_CUSER1.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/BD_CUSER1_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CUSERIN.o: LK1/L1A-BD/BD_CUSERIN.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/BD_CUSERIN_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CUSERIN0.o: LK1/L1A-BD/BD_CUSERIN0.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/BD_CUSERIN0_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_DEBUG.o: LK1/L1A-BD/BD_DEBUG.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/DEBUG_PARAMETERS.o obj/BD_DEBUG_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_DEBUG0.o: LK1/L1A-BD/BD_DEBUG0.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/DEBUG_PARAMETERS.o obj/BD_DEBUG0_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_EIGR.o: LK1/L1A-BD/BD_EIGR.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/BD_EIGR_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_EIGRL.o: LK1/L1A-BD/BD_EIGRL.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/BD_EIGRL_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_FORMOM.o: LK1/L1A-BD/BD_FORMOM.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/MODEL_STUF.o obj/BD_FORMOM_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_GRAV.o: LK1/L1A-BD/BD_GRAV.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/BD_GRAV_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_GRDSET.o: LK1/L1A-BD/BD_GRDSET.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/BD_GRDSET_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_GRDSET0.o: LK1/L1A-BD/BD_GRDSET0.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/BD_GRDSET0_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_GRID.o: LK1/L1A-BD/BD_GRID.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/BD_GRID_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_IMBEDDED_BLANK.o: LK1/L1A-BD/BD_IMBEDDED_BLANK.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/BD_IMBEDDED_BLANK_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_LOAD.o: LK1/L1A-BD/BD_LOAD.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/BD_LOAD_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_LOAD0.o: LK1/L1A-BD/BD_LOAD0.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/BD_LOAD0_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_MAT1.o: LK1/L1A-BD/BD_MAT1.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/MODEL_STUF.o obj/BD_MAT1_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_MAT2.o: LK1/L1A-BD/BD_MAT2.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/PARAMS.o obj/MODEL_STUF.o obj/BD_MAT2_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_MAT8.o: LK1/L1A-BD/BD_MAT8.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/MODEL_STUF.o obj/BD_MAT8_USE_IFs.o obj/CONSTANTS_1.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_MAT9.o: LK1/L1A-BD/BD_MAT9.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/PARAMS.o obj/MODEL_STUF.o obj/BD_MAT9_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_MPC.o: LK1/L1A-BD/BD_MPC.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/BD_MPC_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_MPC0.o: LK1/L1A-BD/BD_MPC0.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/BD_MPC0_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_MPCADD.o: LK1/L1A-BD/BD_MPCADD.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/BD_MPCADD_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_MPCADD0.o: LK1/L1A-BD/BD_MPCADD0.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/BD_MPCADD0_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_NLPARM.o: LK1/L1A-BD/BD_NLPARM.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/NONLINEAR_PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/BD_NLPARM_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_PARAM.o: LK1/L1A-BD/BD_PARAM.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MACHINE_PARAMS.o obj/DOF_TABLES.o obj/PARAMS.o obj/BD_PARAM_USE_IFs.o obj/PENTIUM_II_KIND.o obj/DOF_TABLES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_PARAM0.o: LK1/L1A-BD/BD_PARAM0.f90 obj/PENTIUM_II_KIND.o obj/SCONTR.o obj/IOUNT1.o obj/TIMDAT.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/BD_PARAM0_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_PARVEC.o: LK1/L1A-BD/BD_PARVEC.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/OUTPUT4_MATRICES.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/DOF_TABLES.o obj/BD_PARVEC_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_PARVEC1.o: LK1/L1A-BD/BD_PARVEC1.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/OUTPUT4_MATRICES.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/DOF_TABLES.o obj/BD_PARVEC1_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_PBAR.o: LK1/L1A-BD/BD_PBAR.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/PARAMS.o obj/SCONTR.o obj/CONSTANTS_1.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/BD_PBAR_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_PBARL.o: LK1/L1A-BD/BD_PBARL.f90 obj/PENTIUM_II_KIND.o obj/DERIVED_DATA_TYPES.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/CONSTANTS_1.o obj/TIMDAT.o obj/MODEL_STUF.o obj/SUBR_BEGEND_LEVELS.o obj/BD_PBARL_USE_IFs.o obj/PARAMS.o obj/SCONTR.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_PBEAM.o: LK1/L1A-BD/BD_PBEAM.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/PARAMS.o obj/SCONTR.o obj/CONSTANTS_1.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/PARAMS.o obj/BD_PBEAM_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_PBUSH.o: LK1/L1A-BD/BD_PBUSH.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/PARAMS.o obj/SCONTR.o obj/CONSTANTS_1.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/BD_PBUSH_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_PCOMP.o: LK1/L1A-BD/BD_PCOMP.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/BD_PCOMP_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_PCOMP0.o: LK1/L1A-BD/BD_PCOMP0.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/BD_PCOMP0_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_PCOMP1.o: LK1/L1A-BD/BD_PCOMP1.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/BD_PCOMP1_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_PCOMP10.o: LK1/L1A-BD/BD_PCOMP10.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/BD_PCOMP10_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_PELAS.o: LK1/L1A-BD/BD_PELAS.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/BD_PELAS_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_PLOAD2.o: LK1/L1A-BD/BD_PLOAD2.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/BD_PLOAD2_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_PLOAD4.o: LK1/L1A-BD/BD_PLOAD4.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/BD_PLOAD4_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_PLOTEL.o: LK1/L1A-BD/BD_PLOTEL.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/BD_PLOTEL_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_PMASS.o: LK1/L1A-BD/BD_PMASS.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/BD_PMASS_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_PROD.o: LK1/L1A-BD/BD_PROD.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/BD_PROD_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_PSHEAR.o: LK1/L1A-BD/BD_PSHEAR.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/BD_PSHEAR_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_PSHEL.o: LK1/L1A-BD/BD_PSHEL.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/MODEL_STUF.o obj/BD_PSHEL_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_PSOLID.o: LK1/L1A-BD/BD_PSOLID.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/BD_PSOLID_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_PUSER1.o: LK1/L1A-BD/BD_PUSER1.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/BD_PUSER1_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_PUSERIN.o: LK1/L1A-BD/BD_PUSERIN.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/BD_PUSERIN_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_RBAR.o: LK1/L1A-BD/BD_RBAR.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/BD_RBAR_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_RBE1.o: LK1/L1A-BD/BD_RBE1.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/BD_RBE1_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_RBE2.o: LK1/L1A-BD/BD_RBE2.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/BD_RBE2_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_RBE3.o: LK1/L1A-BD/BD_RBE3.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/BD_RBE3_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_RBE30.o: LK1/L1A-BD/BD_RBE30.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/BD_RBE30_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_RFORCE.o: LK1/L1A-BD/BD_RFORCE.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/BD_RFORCE_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_RSPLINE.o: LK1/L1A-BD/BD_RSPLINE.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/BD_RSPLINE_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_RSPLINE0.o: LK1/L1A-BD/BD_RSPLINE0.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/BD_RSPLINE0_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_SEQGP.o: LK1/L1A-BD/BD_SEQGP.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/BD_SEQGP_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_SLOAD.o: LK1/L1A-BD/BD_SLOAD.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/MODEL_STUF.o obj/BD_SLOAD_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_SLOAD0.o: LK1/L1A-BD/BD_SLOAD0.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/BD_SLOAD0_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_SPC.o: LK1/L1A-BD/BD_SPC.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/DOF_TABLES.o obj/MODEL_STUF.o obj/BD_SPC_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_SPC1.o: LK1/L1A-BD/BD_SPC1.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/DOF_TABLES.o obj/MODEL_STUF.o obj/BD_SPC1_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_SPCADD.o: LK1/L1A-BD/BD_SPCADD.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/BD_SPCADD_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_SPCADD0.o: LK1/L1A-BD/BD_SPCADD0.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/BD_SPCADD0_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_SPOINT.o: LK1/L1A-BD/BD_SPOINT.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/MODEL_STUF.o obj/SUBR_BEGEND_LEVELS.o obj/BD_SPOINT_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_SPOINT0.o: LK1/L1A-BD/BD_SPOINT0.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/BD_SPOINT0_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_SUPORT.o: LK1/L1A-BD/BD_SUPORT.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/BD_SUPORT_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_TEMP.o: LK1/L1A-BD/BD_TEMP.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/BD_TEMP_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_TEMPD.o: LK1/L1A-BD/BD_TEMPD.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/BD_TEMPD_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_TEMPRP.o: LK1/L1A-BD/BD_TEMPRP.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/BD_TEMPRP_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_USET.o: LK1/L1A-BD/BD_USET.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/DOF_TABLES.o obj/BD_USET_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_USET1.o: LK1/L1A-BD/BD_USET1.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/DOF_TABLES.o obj/BD_USET1_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_ACCE.o: LK1/L1A-CC/CC_ACCE.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CC_OUTPUT_DESCRIBERS.o obj/MODEL_STUF.o obj/CC_ACCE_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_DISP.o: LK1/L1A-CC/CC_DISP.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CC_OUTPUT_DESCRIBERS.o obj/MODEL_STUF.o obj/CC_DISP_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_ECHO.o: LK1/L1A-CC/CC_ECHO.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/CC_ECHO_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_ELDA.o: LK1/L1A-CC/CC_ELDA.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/CC_ELDA_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_ELFO.o: LK1/L1A-CC/CC_ELFO.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/CC_ELFO_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_ENFO.o: LK1/L1A-CC/CC_ENFO.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/CC_ENFO_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_GPFO.o: LK1/L1A-CC/CC_GPFO.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/CC_GPFO_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_LABE.o: LK1/L1A-CC/CC_LABE.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/CC_LABE_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_LOAD.o: LK1/L1A-CC/CC_LOAD.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/CC_LOAD_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_METH.o: LK1/L1A-CC/CC_METH.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/CC_METH_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_MPC.o: LK1/L1A-CC/CC_MPC.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/CC_MPC_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_MPCF.o: LK1/L1A-CC/CC_MPCF.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CC_OUTPUT_DESCRIBERS.o obj/MODEL_STUF.o obj/CC_MPCF_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_NLPARM.o: LK1/L1A-CC/CC_NLPARM.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/NONLINEAR_PARAMS.o obj/CC_NLPARM_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_OLOA.o: LK1/L1A-CC/CC_OLOA.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CC_OUTPUT_DESCRIBERS.o obj/MODEL_STUF.o obj/CC_OLOA_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_OUTPUTS.o: LK1/L1A-CC/CC_OUTPUTS.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CC_OUTPUTS_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_SET.o: LK1/L1A-CC/CC_SET.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/CC_SET_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_SET0.o: LK1/L1A-CC/CC_SET0.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CC_SET0_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_SPC.o: LK1/L1A-CC/CC_SPC.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/CC_SPC_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_SPCF.o: LK1/L1A-CC/CC_SPCF.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CC_OUTPUT_DESCRIBERS.o obj/MODEL_STUF.o obj/CC_SPCF_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_STRE.o: LK1/L1A-CC/CC_STRE.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/CC_STRE_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_STRN.o: LK1/L1A-CC/CC_STRN.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/CC_STRN_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_SUBC.o: LK1/L1A-CC/CC_SUBC.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/CC_SUBC_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_SUBT.o: LK1/L1A-CC/CC_SUBT.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/CC_SUBT_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_TEMP.o: LK1/L1A-CC/CC_TEMP.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/CC_TEMP_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_TITL.o: LK1/L1A-CC/CC_TITL.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/CC_TITL_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CHK_CC_CMD_DESCRIBERS.o: LK1/L1A-CC/CHK_CC_CMD_DESCRIBERS.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CC_OUTPUT_DESCRIBERS.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/CHK_CC_CMD_DESCRIBERS_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CORD_PROC.o: LK1/L1B/CORD_PROC.f90 obj/PENTIUM_II_KIND.o obj/CONSTANTS_1.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/CORD_PROC_USE_IFs.o obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DOF_PROC.o: LK1/L1B/DOF_PROC.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/DOF_PROC_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GRID_PROC.o: LK1/L1B/GRID_PROC.f90 obj/PENTIUM_II_KIND.o obj/CONSTANTS_1.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/GRID_PROC_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/OU4_PARTVEC_PROC.o: LK1/L1B/OU4_PARTVEC_PROC.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/CONSTANTS_1.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/SUBR_BEGEND_LEVELS.o obj/DOF_TABLES.o obj/OUTPUT4_MATRICES.o obj/MODEL_STUF.o obj/PARAMS.o obj/OU4_PARTVEC_PROC_USE_IFs.o obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/PENTIUM_II_KIND.o obj/PENTIUM_II_KIND.o obj/DOF_TABLES.o obj/PENTIUM_II_KIND.o
	$(F77) $(FLAGS) -c $< -o $@
obj/RDOF.o: LK1/L1B/RDOF.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/RDOF_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SEQ_PROC.o: LK1/L1B/SEQ_PROC.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/IOUNT1.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/DEBUG_PARAMETERS.o obj/SEQ_PROC_USE_IFs.o obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/MODEL_STUF.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/IOUNT1.o obj/PARAMS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/TDOF_COL_NUM.o: LK1/L1B/TDOF_COL_NUM.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/TDOF_COL_NUM_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/TDOF_PROC.o: LK1/L1B/TDOF_PROC.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/DOF_TABLES.o obj/DEBUG_PARAMETERS.o obj/MODEL_STUF.o obj/TDOF_PROC_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/TSET_PROC.o: LK1/L1B/TSET_PROC.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/DOF_TABLES.o obj/MODEL_STUF.o obj/TSET_PROC_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/TSET_PROC_FOR_MPCS.o: LK1/L1B/TSET_PROC_FOR_MPCS.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/DOF_TABLES.o obj/MODEL_STUF.o obj/TSET_PROC_FOR_MPCS_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/TSET_PROC_FOR_OMITS.o: LK1/L1B/TSET_PROC_FOR_OMITS.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/DOF_TABLES.o obj/MODEL_STUF.o obj/TSET_PROC_FOR_OMITS_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/TSET_PROC_FOR_RIGELS.o: LK1/L1B/TSET_PROC_FOR_RIGELS.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/DOF_TABLES.o obj/MODEL_STUF.o obj/TSET_PROC_FOR_RIGELS_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/TSET_PROC_FOR_SPCS.o: LK1/L1B/TSET_PROC_FOR_SPCS.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/PARAMS.o obj/DOF_TABLES.o obj/MODEL_STUF.o obj/TSET_PROC_FOR_SPCS_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/TSET_PROC_FOR_SUPORTS.o: LK1/L1B/TSET_PROC_FOR_SUPORTS.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/PARAMS.o obj/DOF_TABLES.o obj/MODEL_STUF.o obj/TSET_PROC_FOR_SUPORTS_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/USET_PROC.o: LK1/L1B/USET_PROC.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/PARAMS.o obj/DOF_TABLES.o obj/MODEL_STUF.o obj/USET_PROC_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CONM2_PROC_1.o: LK1/L1C/CONM2_PROC_1.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/DEBUG_PARAMETERS.o obj/CONM2_PROC_1_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CONM2_PROC_2.o: LK1/L1C/CONM2_PROC_2.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/DEBUG_PARAMETERS.o obj/CONM2_PROC_2_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ELEM_PROP_MATL_IIDS.o: LK1/L1C/ELEM_PROP_MATL_IIDS.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/ELEM_PROP_MATL_IIDS_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ELEM_TRANSFORM_LBG.o: LK1/L1C/ELEM_TRANSFORM_LBG.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/ELEM_TRANSFORM_LBG_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ELESORT.o: LK1/L1C/ELESORT.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/DEBUG_PARAMETERS.o obj/ELESORT_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ELSAVE.o: LK1/L1C/ELSAVE.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/ELSAVE_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GPWG.o: LK1/L1C/GPWG.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/DEBUG_PARAMETERS.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/GPWG_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GPWG_PMOI.o: LK1/L1C/GPWG_PMOI.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/PARAMS.o obj/LAPACK_STD_EIG_1.o obj/SUBR_BEGEND_LEVELS.o obj/GPWG_PMOI_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GPWG_USERIN.o: LK1/L1C/GPWG_USERIN.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/GPWG_USERIN_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/RB_DISP_MATRIX_PROC.o: LK1/L1C/RB_DISP_MATRIX_PROC.f90 obj/PENTIUM_II_KIND.o obj/CONSTANTS_1.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/DOF_TABLES.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/RIGID_BODY_DISP_MATS.o obj/DEBUG_PARAMETERS.o obj/RB_DISP_MATRIX_PROC_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SUBCASE_PROC.o: LK1/L1C/SUBCASE_PROC.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/SUBCASE_PROC_USE_IFs.o obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/PENTIUM_II_KIND.o
	$(F77) $(FLAGS) -c $< -o $@
obj/EPTL.o: LK1/L1D/EPTL.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/CONSTANTS_1.o obj/PARAMS.o obj/TIMDAT.o obj/DOF_TABLES.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/EPTL_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/FORCE_MOM_PROC.o: LK1/L1D/FORCE_MOM_PROC.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/DOF_TABLES.o obj/MODEL_STUF.o obj/FORCE_MOM_PROC_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_GRID_6X6_MASS.o: LK1/L1D/GET_GRID_6X6_MASS.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/DOF_TABLES.o obj/SPARSE_MATRICES.o obj/GET_GRID_6X6_MASS_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GRAV_PROC.o: LK1/L1D/GRAV_PROC.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/PARAMS.o obj/CONSTANTS_1.o obj/DOF_TABLES.o obj/MODEL_STUF.o obj/GRAV_PROC_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MPC_PROC.o: LK1/L1D/MPC_PROC.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/DOF_TABLES.o obj/MPC_PROC_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/PRESSURE_DATA_PROC.o: LK1/L1D/PRESSURE_DATA_PROC.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/IOUNT1.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/PRESSURE_DATA_PROC_USE_IFs.o obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/RBE2_PROC.o: LK1/L1D/RBE2_PROC.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/DOF_TABLES.o obj/MODEL_STUF.o obj/DEBUG_PARAMETERS.o obj/RBE2_PROC_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/RBE3_PROC.o: LK1/L1D/RBE3_PROC.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/DOF_TABLES.o obj/RBE3_PROC_USE_IFs.o obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/DOF_TABLES.o obj/MODEL_STUF.o obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/CONSTANTS_1.o obj/DOF_TABLES.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/RFORCE_PROC.o: LK1/L1D/RFORCE_PROC.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/DOF_TABLES.o obj/MODEL_STUF.o obj/RFORCE_PROC_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/RIGID_ELEM_PROC.o: LK1/L1D/RIGID_ELEM_PROC.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/RIGID_ELEM_PROC_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/RSPLINE_PROC.o: LK1/L1D/RSPLINE_PROC.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/DOF_TABLES.o obj/MODEL_STUF.o obj/PARAMS.o obj/DEBUG_PARAMETERS.o obj/RSPLINE_PROC_USE_IFs.o obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SLOAD_PROC.o: LK1/L1D/SLOAD_PROC.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/DOF_TABLES.o obj/MODEL_STUF.o obj/SLOAD_PROC_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/TEMPERATURE_DATA_PROC.o: LK1/L1D/TEMPERATURE_DATA_PROC.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/IOUNT1.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/DEBUG_PARAMETERS.o obj/TEMPERATURE_DATA_PROC_USE_IFs.o obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/MODEL_STUF.o obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/PARAMS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/YS_ARRAY.o: LK1/L1D/YS_ARRAY.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/IOUNT1.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/DOF_TABLES.o obj/MODEL_STUF.o obj/COL_VECS.o obj/YS_ARRAY_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/EMP.o: LK1/L1E/EMP.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/DOF_TABLES.o obj/MODEL_STUF.o obj/EMS_ARRAYS.o obj/EMP_USE_IFs.o obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/MODEL_STUF.o obj/EMS_ARRAYS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/EMP0.o: LK1/L1E/EMP0.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/EMP0_USE_IFs.o obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ESP.o: LK1/L1E/ESP.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/DOF_TABLES.o obj/NONLINEAR_PARAMS.o obj/MODEL_STUF.o obj/STF_ARRAYS.o obj/STF_TEMPLATE_ARRAYS.o obj/DEBUG_PARAMETERS.o obj/ESP_USE_IFs.o obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/MODEL_STUF.o obj/STF_ARRAYS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ESP0.o: LK1/L1E/ESP0.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/NONLINEAR_PARAMS.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/ESP0_USE_IFs.o obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/NONLINEAR_PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/NONLINEAR_PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/NONLINEAR_PARAMS.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ESP0_FINAL.o: LK1/L1E/ESP0_FINAL.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/DOF_TABLES.o obj/MODEL_STUF.o obj/STF_ARRAYS.o obj/DEBUG_PARAMETERS.o obj/ESP0_FINAL_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/KGG_SINGULARITY_PROC.o: LK1/L1E/KGG_SINGULARITY_PROC.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/CONSTANTS_1.o obj/PARAMS.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/DOF_TABLES.o obj/DEBUG_PARAMETERS.o obj/MODEL_STUF.o obj/KGG_SINGULARITY_PROC_USE_IFs.o obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/CONSTANTS_1.o obj/LAPACK_STD_EIG_1.o obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/LAPACK_STD_EIG_1.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MGGC_MASS_MATRIX.o: LK1/L1E/MGGC_MASS_MATRIX.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/CONSTANTS_1.o obj/PARAMS.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/SPARSE_MATRICES.o obj/MGGC_MASS_MATRIX_USE_IFs.o obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/PARAMS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MGGS_MASS_MATRIX.o: LK1/L1E/MGGS_MASS_MATRIX.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/PARAMS.o obj/TIMDAT.o obj/DOF_TABLES.o obj/MODEL_STUF.o obj/SPARSE_MATRICES.o obj/SUBR_BEGEND_LEVELS.o obj/MGGS_MASS_MATRIX_USE_IFs.o obj/PENTIUM_II_KIND.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SPARSE_KGG.o: LK1/L1E/SPARSE_KGG.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/NONLINEAR_PARAMS.o obj/MODEL_STUF.o obj/DOF_TABLES.o obj/STF_ARRAYS.o obj/SPARSE_MATRICES.o obj/DEBUG_PARAMETERS.o obj/SPARSE_KGG_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SPARSE_KGGD.o: LK1/L1E/SPARSE_KGGD.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/NONLINEAR_PARAMS.o obj/MODEL_STUF.o obj/DOF_TABLES.o obj/STF_ARRAYS.o obj/SPARSE_MATRICES.o obj/SPARSE_KGGD_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SPARSE_MGG.o: LK1/L1E/SPARSE_MGG.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/DEBUG_PARAMETERS.o obj/CONSTANTS_1.o obj/DOF_TABLES.o obj/MODEL_STUF.o obj/PARAMS.o obj/EMS_ARRAYS.o obj/SPARSE_MATRICES.o obj/SCRATCH_MATRICES.o obj/SPARSE_MGG_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SPARSE_PG.o: LK1/L1E/SPARSE_PG.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/PARAMS.o obj/NONLINEAR_PARAMS.o obj/MODEL_STUF.o obj/SPARSE_MATRICES.o obj/SPARSE_PG_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SPARSE_RMG.o: LK1/L1E/SPARSE_RMG.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/PARAMS.o obj/SPARSE_MATRICES.o obj/SPARSE_RMG_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CHAR_FLD.o: LK1/L1U/CHAR_FLD.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/CHAR_FLD_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CHECK_BAR_MOIs.o: LK1/L1U/CHECK_BAR_MOIs.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/CHECK_BAR_MOIs_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CRDERR.o: LK1/L1U/CRDERR.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CRDERR_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_ANSID.o: LK1/L1U/GET_ANSID.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/GET_ANSID_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_SETID.o: LK1/L1U/GET_SETID.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/GET_SETID_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/I4FLD.o: LK1/L1U/I4FLD.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/I4FLD_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/IP6CHK.o: LK1/L1U/IP6CHK.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/IP6CHK_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/LEFT_ADJ_BDFLD.o: LK1/L1U/LEFT_ADJ_BDFLD.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/LEFT_ADJ_BDFLD_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MKCARD.o: LK1/L1U/MKCARD.f90 obj/PENTIUM_II_KIND.o obj/SCONTR.o obj/MKCARD_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MKJCARD.o: LK1/L1U/MKJCARD.f90 obj/PENTIUM_II_KIND.o obj/SCONTR.o obj/MKJCARD_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MKJCARD_08.o: LK1/L1U/MKJCARD_08.f90 obj/PENTIUM_II_KIND.o
	$(F77) $(FLAGS) -c $< -o $@
obj/NEXTC.o: LK1/L1U/NEXTC.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/NEXTC_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/NEXTC0.o: LK1/L1U/NEXTC0.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/NEXTC0_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/NEXTC2.o: LK1/L1U/NEXTC2.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/NEXTC2_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/NEXTC20.o: LK1/L1U/NEXTC20.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/NEXTC20_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/R8FLD.o: LK1/L1U/R8FLD.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/CONSTANTS_1.o obj/R8FLD_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/STOKEN.o: LK1/L1U/STOKEN.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/DEBUG_PARAMETERS.o obj/STOKEN_USE_IFs.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/TOKCHK.o: LK1/L1U/TOKCHK.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/TOKCHK_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_EMS_ARRAYS.o: LK1/LINK1/ALLOCATE_EMS_ARRAYS.f90 obj/PENTIUM_II_KIND.o obj/CONSTANTS_1.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/EMS_ARRAYS.o obj/SUBR_BEGEND_LEVELS.o obj/ALLOCATE_EMS_ARRAYS_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_L1_MGG.o: LK1/LINK1/ALLOCATE_L1_MGG.f90 obj/PENTIUM_II_KIND.o obj/CONSTANTS_1.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/SPARSE_MATRICES.o obj/ALLOCATE_L1_MGG_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_STF_ARRAYS.o: LK1/LINK1/ALLOCATE_STF_ARRAYS.f90 obj/PENTIUM_II_KIND.o obj/CONSTANTS_1.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/NONLINEAR_PARAMS.o obj/STF_ARRAYS.o obj/SUBR_BEGEND_LEVELS.o obj/ALLOCATE_STF_ARRAYS_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_TEMPLATE.o: LK1/LINK1/ALLOCATE_TEMPLATE.f90 obj/PENTIUM_II_KIND.o obj/CONSTANTS_1.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/STF_TEMPLATE_ARRAYS.o obj/ALLOCATE_STF_ARRAYS_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEALLOCATE_EMS_ARRAYS.o: LK1/LINK1/DEALLOCATE_EMS_ARRAYS.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/EMS_ARRAYS.o obj/DEALLOCATE_EMS_ARRAYS_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEALLOCATE_L1_MGG.o: LK1/LINK1/DEALLOCATE_L1_MGG.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/SPARSE_MATRICES.o obj/DEALLOCATE_L1_MGG_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEALLOCATE_STF_ARRAYS.o: LK1/LINK1/DEALLOCATE_STF_ARRAYS.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/STF_ARRAYS.o obj/DEALLOCATE_STF_ARRAYS_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEALLOCATE_TEMPLATE.o: LK1/LINK1/DEALLOCATE_TEMPLATE.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/STF_TEMPLATE_ARRAYS.o obj/DEALLOCATE_TEMPLATE_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/LINK0.o: LK1/LINK1/LINK0.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/IOUNT1.o obj/IOUNT1.o obj/IOUNT1.o obj/IOUNT1.o obj/SCONTR.o obj/SCONTR.o obj/TIMDAT.o obj/DOF_TABLES.o obj/PARAMS.o obj/NONLINEAR_PARAMS.o obj/MACHINE_PARAMS.o obj/MODEL_STUF.o obj/DEBUG_PARAMETERS.o obj/BANDIT_MODULE.o obj/RIGID_BODY_DISP_MATS.o obj/SPARSE_MATRICES.o obj/OUTPUT4_MATRICES.o obj/LINK0_USE_IFs.o obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/SCONTR.o
	$(F77) $(FLAGS) -c $< -o $@
obj/LINK1.o: LK1/LINK1/LINK1.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/IOUNT1.o obj/IOUNT1.o obj/IOUNT1.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/DOF_TABLES.o obj/PARAMS.o obj/NONLINEAR_PARAMS.o obj/MODEL_STUF.o obj/DEBUG_PARAMETERS.o obj/LINK1_USE_IFs.o obj/PENTIUM_II_KIND.o obj/SCONTR.o
	$(F77) $(FLAGS) -c $< -o $@
obj/LINK1_RESTART_DATA.o: LK1/LINK1/LINK1_RESTART_DATA.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/PARAMS.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/LINK1_RESTART_DATA_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/PRINT_CONSTANTS_1.o: LK1/LINK1/PRINT_CONSTANTS_1.f90 obj/PENTIUM_II_KIND.o obj/CONSTANTS_1.o obj/IOUNT1.o obj/SCONTR.o obj/PRINT_CONSTANTS_1_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/PRINT_ORDER.o: LK1/LINK1/PRINT_ORDER.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/PRINT_ORDER_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_ENF_TO_L1O.o: LK1/LINK1/WRITE_ENF_TO_L1O.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/DOF_TABLES.o obj/MODEL_STUF.o obj/SUBR_BEGEND_LEVELS.o obj/WRITE_ENF_TO_L1O_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_L2_GMN_2.o: LK2/ALLOCATE_L2_GMN_2.f90 obj/PENTIUM_II_KIND.o obj/CONSTANTS_1.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/SUBR_BEGEND_LEVELS.o obj/SPARSE_MATRICES.o obj/ALLOCATE_L2_GMN_2_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_L2_GOA_2.o: LK2/ALLOCATE_L2_GOA_2.f90 obj/PENTIUM_II_KIND.o obj/CONSTANTS_1.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/SUBR_BEGEND_LEVELS.o obj/SPARSE_MATRICES.o obj/ALLOCATE_L2_GOA_2_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEALLOCATE_L2_GMN_2.o: LK2/DEALLOCATE_L2_GMN_2.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/SUBR_BEGEND_LEVELS.o obj/SPARSE_MATRICES.o obj/DEALLOCATE_L2_GMN_2_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEALLOCATE_L2_GOA_2.o: LK2/DEALLOCATE_L2_GOA_2.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/SUBR_BEGEND_LEVELS.o obj/SPARSE_MATRICES.o obj/DEALLOCATE_L2_GOA_2_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/LINK2.o: LK2/LINK2.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/IOUNT1.o obj/IOUNT1.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/RIGID_BODY_DISP_MATS.o obj/PARAMS.o obj/NONLINEAR_PARAMS.o obj/DEBUG_PARAMETERS.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/OUTPUT4_MATRICES.o obj/LINK2_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/REDUCE_A_LR.o: LK2/REDUCE_A_LR.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/DOF_TABLES.o obj/RIGID_BODY_DISP_MATS.o obj/PARAMS.o obj/NONLINEAR_PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/OUTPUT4_MATRICES.o obj/REDUCE_A_LR_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/REDUCE_F_AO.o: LK2/REDUCE_F_AO.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/NONLINEAR_PARAMS.o obj/TIMDAT.o obj/DOF_TABLES.o obj/RIGID_BODY_DISP_MATS.o obj/SUBR_BEGEND_LEVELS.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/SCRATCH_MATRICES.o obj/REDUCE_F_AO_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/REDUCE_G_NM.o: LK2/REDUCE_G_NM.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/NONLINEAR_PARAMS.o obj/DOF_TABLES.o obj/MODEL_STUF.o obj/RIGID_BODY_DISP_MATS.o obj/SUBR_BEGEND_LEVELS.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/OUTPUT4_MATRICES.o obj/SCRATCH_MATRICES.o obj/REDUCE_G_NM_USE_IFs.o obj/PENTIUM_II_KIND.o obj/SCONTR.o obj/IOUNT1.o obj/PARAMS.o obj/DOF_TABLES.o obj/MODEL_STUF.o obj/PENTIUM_II_KIND.o obj/SCONTR.o obj/IOUNT1.o obj/PARAMS.o obj/CONSTANTS_1.o obj/DOF_TABLES.o obj/MODEL_STUF.o obj/SPARSE_MATRICES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/REDUCE_KAAD_TO_KLLD.o: LK2/REDUCE_KAAD_TO_KLLD.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/SPARSE_MATRICES.o obj/SCRATCH_MATRICES.o obj/REDUCE_KAAD_TO_KLLD_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/REDUCE_KAA_TO_KLL.o: LK2/REDUCE_KAA_TO_KLL.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/SPARSE_MATRICES.o obj/SCRATCH_MATRICES.o obj/REDUCE_KAA_TO_KLL_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/REDUCE_KFFD_TO_KAAD.o: LK2/REDUCE_KFFD_TO_KAAD.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/SCRATCH_MATRICES.o obj/REDUCE_KFFD_TO_KAAD_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/REDUCE_KFF_TO_KAA.o: LK2/REDUCE_KFF_TO_KAA.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/FULL_MATRICES.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/SCRATCH_MATRICES.o obj/REDUCE_KFF_TO_KAA_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/REDUCE_KGGD_TO_KNND.o: LK2/REDUCE_KGGD_TO_KNND.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/SCRATCH_MATRICES.o obj/REDUCE_KGGD_TO_KNND_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/REDUCE_KGG_TO_KNN.o: LK2/REDUCE_KGG_TO_KNN.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/FULL_MATRICES.o obj/SCRATCH_MATRICES.o obj/REDUCE_KGG_TO_KNN_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/REDUCE_KNND_TO_KFFD.o: LK2/REDUCE_KNND_TO_KFFD.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/SCRATCH_MATRICES.o obj/REDUCE_KNND_TO_KFFD_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/REDUCE_KNN_TO_KFF.o: LK2/REDUCE_KNN_TO_KFF.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/SCRATCH_MATRICES.o obj/REDUCE_KNN_TO_KFF_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/REDUCE_MAA_TO_MLL.o: LK2/REDUCE_MAA_TO_MLL.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/SPARSE_MATRICES.o obj/SCRATCH_MATRICES.o obj/REDUCE_MAA_TO_MLL_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/REDUCE_MFF_TO_MAA.o: LK2/REDUCE_MFF_TO_MAA.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/FULL_MATRICES.o obj/SCRATCH_MATRICES.o obj/REDUCE_MFF_TO_MAA_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/REDUCE_MGG_TO_MNN.o: LK2/REDUCE_MGG_TO_MNN.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/FULL_MATRICES.o obj/SCRATCH_MATRICES.o obj/REDUCE_MGG_TO_MNN_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/REDUCE_MNN_TO_MFF.o: LK2/REDUCE_MNN_TO_MFF.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/SCRATCH_MATRICES.o obj/REDUCE_MNN_TO_MFF_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/REDUCE_N_FS.o: LK2/REDUCE_N_FS.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/DOF_TABLES.o obj/RIGID_BODY_DISP_MATS.o obj/PARAMS.o obj/NONLINEAR_PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/COL_VECS.o obj/DEBUG_PARAMETERS.o obj/SCRATCH_MATRICES.o obj/REDUCE_N_FS_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/REDUCE_PA_TO_PL.o: LK2/REDUCE_PA_TO_PL.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/REDUCE_PA_TO_PL_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/REDUCE_PF_TO_PA.o: LK2/REDUCE_PF_TO_PA.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/FULL_MATRICES.o obj/SCRATCH_MATRICES.o obj/REDUCE_PF_TO_PA_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/REDUCE_PG_TO_PN.o: LK2/REDUCE_PG_TO_PN.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/FULL_MATRICES.o obj/SCRATCH_MATRICES.o obj/REDUCE_PG_TO_PN_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/REDUCE_PN_TO_PF.o: LK2/REDUCE_PN_TO_PF.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/COL_VECS.o obj/FULL_MATRICES.o obj/DEBUG_PARAMETERS.o obj/SCRATCH_MATRICES.o obj/REDUCE_PN_TO_PF_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SOLVE_GMN.o: LK2/SOLVE_GMN.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/DEBUG_PARAMETERS.o obj/SOLVE_GMN_USE_IFs.o obj/PENTIUM_II_KIND.o obj/CONSTANTS_1.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/SPARSE_MATRICES.o obj/FULL_MATRICES.o obj/LAPACK_LIN_EQN_DGE.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SOLVE_GOA.o: LK2/SOLVE_GOA.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/SPARSE_MATRICES.o obj/DEBUG_PARAMETERS.o obj/LAPACK_LIN_EQN_DPB.o obj/SOLVE_GOA_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SOLVE_UO0.o: LK2/SOLVE_UO0.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/SPARSE_MATRICES.o obj/COL_VECS.o obj/LAPACK_LIN_EQN_DPB.o obj/SOLVE_UO0_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/STIFF_MAT_EQUIL_CHK.o: LK2/STIFF_MAT_EQUIL_CHK.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/DOF_TABLES.o obj/DEBUG_PARAMETERS.o obj/LAPACK_DPB_MATRICES.o obj/LAPACK_BLAS_AUX.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/DEBUG_PARAMETERS.o obj/STIFF_MAT_EQUIL_CHK_USE_IFs.o obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/CONSTANTS_1.o obj/DOF_TABLES.o obj/PARAMS.o obj/MACHINE_PARAMS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/EPSCALC.o: LK3/EPSCALC.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/MACHINE_PARAMS.o obj/LAPACK_DPB_MATRICES.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/COL_VECS.o obj/LAPACK_BLAS_AUX.o obj/EPSCALC_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/LINK3.o: LK3/LINK3.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/PARAMS.o obj/SPARSE_MATRICES.o obj/LAPACK_DPB_MATRICES.o obj/COL_VECS.o obj/MACHINE_PARAMS.o obj/DEBUG_PARAMETERS.o obj/LAPACK_BLAS_AUX.o obj/LAPACK_LIN_EQN_DPB.o
	$(F77) $(FLAGS) -c $< -o $@
obj/VECINORM.o: LK3/VECINORM.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/VECINORM_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CALC_GEN_MASS.o: LK4/CALC_GEN_MASS.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/EIGEN_MATRICES_1.o obj/MODEL_STUF.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/LAPACK_BLAS_AUX.o obj/CALC_GEN_MASS_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/EIG_GIV_MGIV.o: LK4/EIG_GIV_MGIV.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/EIGEN_MATRICES_1.o obj/MODEL_STUF.o obj/LAPACK_DPB_MATRICES.o obj/SPARSE_MATRICES.o obj/DEBUG_PARAMETERS.o obj/LAPACK_GIV_MGIV_EIG.o obj/EIG_GIV_MGIV_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/EIG_INV_PWR.o: LK4/EIG_INV_PWR.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/EIGEN_MATRICES_1.o obj/MODEL_STUF.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/LAPACK_LIN_EQN_DPB.o obj/DEBUG_PARAMETERS.o obj/EIG_INV_PWR_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/EIG_LANCZOS_ARPACK.o: LK4/EIG_LANCZOS_ARPACK.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/PARAMS.o obj/DOF_TABLES.o obj/SUBR_BEGEND_LEVELS.o obj/EIGEN_MATRICES_1.o obj/MODEL_STUF.o obj/ARPACK_MATRICES_1.o obj/SPARSE_MATRICES.o obj/ARPACK_LANCZOS_EIG.o obj/EIG_LANCZOS_ARPACK_USE_IFs.o obj/LAPACK_GIV_MGIV_EIG.o obj/LAPACK_LIN_EQN_DGE.o obj/LAPACK_BLAS_AUX.o
	$(F77) $(FLAGS) -c $< -o $@
obj/EIG_SUMMARY.o: LK4/EIG_SUMMARY.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/EIGEN_MATRICES_1.o obj/MODEL_STUF.o obj/EIG_SUMMARY_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/INVERT_EIGENS.o: LK4/INVERT_EIGENS.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MACHINE_PARAMS.o obj/MODEL_STUF.o obj/LAPACK_BLAS_AUX.o obj/INVERT_EIGENS_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/LINK4.o: LK4/LINK4.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/PARAMS.o obj/MODEL_STUF.o obj/SPARSE_MATRICES.o obj/OUTPUT4_MATRICES.o obj/EIGEN_MATRICES_1.o obj/LAPACK_DPB_MATRICES.o obj/DEBUG_PARAMETERS.o obj/LINK4_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/RENORM_ON_MASS.o: LK4/RENORM_ON_MASS.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/EIGEN_MATRICES_1.o obj/MODEL_STUF.o obj/DEBUG_PARAMETERS.o obj/RENORM_ON_MASS_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BUILD_A_LR.o: LK5/BUILD_A_LR.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/COL_VECS.o obj/BUILD_A_LR_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BUILD_F_AO.o: LK5/BUILD_F_AO.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/NONLINEAR_PARAMS.o obj/SPARSE_MATRICES.o obj/COL_VECS.o obj/BUILD_F_AO_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BUILD_G_NM.o: LK5/BUILD_G_NM.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/SPARSE_MATRICES.o obj/COL_VECS.o obj/BUILD_G_NM_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BUILD_N_FS.o: LK5/BUILD_N_FS.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/COL_VECS.o obj/BUILD_N_FS_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/EXPAND_PHIXA_TO_PHIXG.o: LK5/EXPAND_PHIXA_TO_PHIXG.f90 obj/PENTIUM_II_KIND.o obj/CONSTANTS_1.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/COL_VECS.o obj/PARAMS.o obj/DEBUG_PARAMETERS.o obj/SPARSE_MATRICES.o obj/SUBR_BEGEND_LEVELS.o obj/EXPAND_PHIXA_TO_PHIXG_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/LINK5.o: LK5/LINK5.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/IOUNT1.o obj/IOUNT1.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/PARAMS.o obj/NONLINEAR_PARAMS.o obj/EIGEN_MATRICES_1.o obj/FULL_MATRICES.o obj/SPARSE_MATRICES.o obj/OUTPUT4_MATRICES.o obj/MISC_MATRICES.o obj/COL_VECS.o obj/DEBUG_PARAMETERS.o obj/DOF_TABLES.o obj/MODEL_STUF.o obj/LINK5_USE_IFs.o obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o
	$(F77) $(FLAGS) -c $< -o $@
obj/RENORM.o: LK5/RENORM.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/COL_VECS.o obj/RENORM_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_L6_2.o: LK6/ALLOCATE_L6_2.f90 obj/PENTIUM_II_KIND.o obj/CONSTANTS_1.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/SUBR_BEGEND_LEVELS.o obj/SPARSE_MATRICES.o obj/ALLOCATE_L6_2_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CALC_CB_MEFM_MPF.o: LK6/CALC_CB_MEFM_MPF.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTs_1.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/RIGID_BODY_DISP_MATS.o obj/SPARSE_MATRICES.o obj/SCRATCH_MATRICES.o obj/EIGEN_MATRICES_1.o obj/CALC_CB_MEFM_MPF_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CALC_KRRcb.o: LK6/CALC_KRRcb.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/PARAMS.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/SCRATCH_MATRICES.o obj/LAPACK_DPB_MATRICES.o obj/SUBR_BEGEND_LEVELS.o obj/CALC_KRRcb_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CALC_MRN.o: LK6/CALC_MRN.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/PARAMS.o obj/EIGEN_MATRICES_1.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/SCRATCH_MATRICES.o obj/SUBR_BEGEND_LEVELS.o obj/CALC_MRN_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CALC_MRRcb.o: LK6/CALC_MRRcb.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/PARAMS.o obj/RIGID_BODY_DISP_MATS.o obj/MODEL_STUF.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/SCRATCH_MATRICES.o obj/SUBR_BEGEND_LEVELS.o obj/CALC_MRRcb_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CALC_PHIZL.o: LK6/CALC_PHIZL.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/CONSTANTS_1.o obj/PARAMS.o obj/TIMDAT.o obj/EIGEN_MATRICES_1.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/SCRATCH_MATRICES.o obj/SUBR_BEGEND_LEVELS.o obj/CALC_PHIZL_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEALLOCATE_L6_2.o: LK6/DEALLOCATE_L6_2.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/SPARSE_MATRICES.o obj/DEALLOCATE_L6_2_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/INTERFACE_FORCE_LTM.o: LK6/INTERFACE_FORCE_LTM.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/SCRATCH_MATRICES.o obj/SUBR_BEGEND_LEVELS.o obj/INTERFACE_FORCE_LTM_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/LINK6.o: LK6/LINK6.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/SCONTR.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/PARAMS.o obj/TIMDAT.o obj/MODEL_STUF.o obj/EIGEN_MATRICES_1.o obj/OUTPUT4_MATRICES.o obj/LAPACK_DPB_MATRICES.o obj/SPARSE_MATRICES.o obj/LINK6_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MERGE_KXX.o: LK6/MERGE_KXX.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/EIGEN_MATRICES_1.o obj/SPARSE_MATRICES.o obj/SUBR_BEGEND_LEVELS.o obj/MERGE_KXX_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MERGE_LTM.o: LK6/MERGE_LTM.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SPARSE_MATRICES.o obj/SUBR_BEGEND_LEVELS.o obj/MERGE_LTM_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MERGE_MXX.o: LK6/MERGE_MXX.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/EIGEN_MATRICES_1.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/SUBR_BEGEND_LEVELS.o obj/MERGE_MXX_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MERGE_PHIXA.o: LK6/MERGE_PHIXA.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/EIGEN_MATRICES_1.o obj/SPARSE_MATRICES.o obj/SUBR_BEGEND_LEVELS.o obj/MERGE_PHIXA_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/NET_CG_LOADS_LTM.o: LK6/NET_CG_LOADS_LTM.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/PARAMS.o obj/RIGID_BODY_DISP_MATS.o obj/MODEL_STUF.o obj/OUTPUT4_MATRICES.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/SCRATCH_MATRICES.o obj/SUBR_BEGEND_LEVELS.o obj/NET_CG_LOADS_LTM_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SOLVE6_SETUP.o: LK6/SOLVE6_SETUP.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/SPARSE_MATRICES.o obj/LAPACK_LIN_EQN_DPB.o obj/SOLVE6_SETUP_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SOLVE_DLR.o: LK6/SOLVE_DLR.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/SPARSE_MATRICES.o obj/LAPACK_LIN_EQN_DPB.o obj/SOLVE_DLR_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SOLVE_PHIZL1.o: LK6/SOLVE_PHIZL1.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/SCRATCH_MATRICES.o obj/SPARSE_MATRICES.o obj/LAPACK_LIN_EQN_DPB.o obj/SOLVE_PHIZL1_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BAR_MARGIN.o: LK9/L91/BAR_MARGIN.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/MODEL_STUF.o obj/BAR_MARGIN_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_MAX_MIN_ABS_STR.o: LK9/L91/GET_MAX_MIN_ABS_STR.f90 obj/PENTIUM_II_KIND.o obj/SCONTR.o obj/IOUNT1.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/MACHINE_PARAMS.o obj/LINK9_STUFF.o obj/SUBR_BEGEND_LEVELS.o obj/GET_MAX_MIN_ABS_STR_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/PRINCIPAL_2D.o: LK9/L91/PRINCIPAL_2D.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/PRINCIPAL_2D_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/PRINCIPAL_3D.o: LK9/L91/PRINCIPAL_3D.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/PRINCIPAL_3D_USE_IFs.o obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/LAPACK_STD_EIG_1.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ROD_MARGIN.o: LK9/L91/ROD_MARGIN.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/MODEL_STUF.o obj/ROD_MARGIN_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_BAR.o: LK9/L91/WRITE_BAR.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/LINK9_STUFF.o obj/WRITE_BAR_USE_IFs.o obj/PENTIUM_II_KIND.o obj/CONSTANTS_1.o obj/MACHINE_PARAMS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_ELEM_ENGR_FORCE.o: LK9/L91/WRITE_ELEM_ENGR_FORCE.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/NONLINEAR_PARAMS.o obj/LINK9_STUFF.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/WRITE_ELEM_ENGR_FORCE_USE_IFs.o obj/PENTIUM_II_KIND.o obj/PENTIUM_II_KIND.o obj/CONSTANTS_1.o obj/MACHINE_PARAMS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_ELEM_NODE_FORCE.o: LK9/L91/WRITE_ELEM_NODE_FORCE.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/SUBR_BEGEND_LEVELS.o obj/LINK9_STUFF.o obj/MODEL_STUF.o obj/MACHINE_PARAMS.o obj/WRITE_ELEM_NODE_FORCE_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_ELEM_STRAINS.o: LK9/L91/WRITE_ELEM_STRAINS.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/NONLINEAR_PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/LINK9_STUFF.o obj/MODEL_STUF.o obj/CC_OUTPUT_DESCRIBERS.o obj/WRITE_ELEM_STRAINS_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_ELEM_STRESSES.o: LK9/L91/WRITE_ELEM_STRESSES.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/NONLINEAR_PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/LINK9_STUFF.o obj/MODEL_STUF.o obj/CC_OUTPUT_DESCRIBERS.o obj/WRITE_ELEM_STRESSES_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_FEMAP_ELFO_VECS.o: LK9/L91/WRITE_FEMAP_ELFO_VECS.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/FEMAP_ARRAYS.o obj/SUBR_BEGEND_LEVELS.o obj/WRITE_FEMAP_ELFO_VECS_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_FEMAP_GRID_VECS.o: LK9/L91/WRITE_FEMAP_GRID_VECS.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/SUBR_BEGEND_LEVELS.o obj/WRITE_FEMAP_GRID_VECS_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_FEMAP_STRE_VECS.o: LK9/L91/WRITE_FEMAP_STRE_VECS.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CC_OUTPUT_DESCRIBERS.o obj/FEMAP_ARRAYS.o obj/SUBR_BEGEND_LEVELS.o obj/WRITE_FEMAP_STRE_VECS_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_FEMAP_STRN_VECS.o: LK9/L91/WRITE_FEMAP_STRN_VECS.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CC_OUTPUT_DESCRIBERS.o obj/FEMAP_ARRAYS.o obj/SUBR_BEGEND_LEVELS.o obj/WRITE_FEMAP_STRN_VECS_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_GRD_PCH_OUTPUTS.o: LK9/L91/WRITE_GRD_PCH_OUTPUTS.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/NONLINEAR_PARAMS.o obj/LINK9_STUFF.o obj/MODEL_STUF.o obj/EIGEN_MATRICES_1.o obj/WRITE_GRD_PCH_OUTPUTS_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_GRD_PRT_OUTPUTS.o: LK9/L91/WRITE_GRD_PRT_OUTPUTS.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/NONLINEAR_PARAMS.o obj/LINK9_STUFF.o obj/MODEL_STUF.o obj/MACHINE_PARAMS.o obj/WRITE_GRD_PRT_OUTPUTS_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_MEFFMASS.o: LK9/L91/WRITE_MEFFMASS.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/EIGEN_MATRICES_1.o obj/MODEL_STUF.o obj/PARAMS.o obj/WRITE_MEFFMASS_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_MPFACTOR.o: LK9/L91/WRITE_MPFACTOR.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/EIGEN_MATRICES_1.o obj/MODEL_STUF.o obj/PARAMS.o obj/DOF_TABLES.o obj/WRITE_MPFACTOR_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_PLY_STRAINS.o: LK9/L91/WRITE_PLY_STRAINS.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/NONLINEAR_PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/LINK9_STUFF.o obj/MODEL_STUF.o obj/CC_OUTPUT_DESCRIBERS.o obj/MACHINE_PARAMS.o obj/WRITE_PLY_STRAINS_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_PLY_STRESSES.o: LK9/L91/WRITE_PLY_STRESSES.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/NONLINEAR_PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/LINK9_STUFF.o obj/MODEL_STUF.o obj/CC_OUTPUT_DESCRIBERS.o obj/MACHINE_PARAMS.o obj/WRITE_PLY_STRESSES_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_ROD.o: LK9/L91/WRITE_ROD.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/LINK9_STUFF.o obj/WRITE_ROD_USE_IFs.o obj/PENTIUM_II_KIND.o obj/CONSTANTS_1.o obj/MACHINE_PARAMS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRT_REAL_TO_CHAR_VAR.o: LK9/L91/WRT_REAL_TO_CHAR_VAR.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/WRT_REAL_TO_CHAR_VAR_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CALC_ELEM_NODE_FORCES.o: LK9/L92/CALC_ELEM_NODE_FORCES.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/CALC_ELEM_NODE_FORCES_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CALC_ELEM_STRAINS.o: LK9/L92/CALC_ELEM_STRAINS.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/MODEL_STUF.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/CALC_ELEM_STRAINS_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CALC_ELEM_STRESSES.o: LK9/L92/CALC_ELEM_STRESSES.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/MODEL_STUF.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/CALC_ELEM_STRESSES_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ELEM_STRE_STRN_ARRAYS.o: LK9/L92/ELEM_STRE_STRN_ARRAYS.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/DEBUG_PARAMETERS.o obj/PARAMS.o obj/ELEM_STRE_STRN_ARRAYS_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ELMDIS.o: LK9/L92/ELMDIS.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/DOF_TABLES.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/COL_VECS.o obj/DEBUG_PARAMETERS.o obj/ELMDIS_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ELMDIS_PLY.o: LK9/L92/ELMDIS_PLY.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/CONSTANTS_1.o obj/TIMDAT.o obj/MODEL_STUF.o obj/SUBR_BEGEND_LEVELS.o obj/ELMDIS_PLY_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_COMP_SHELL_ALLOWS.o: LK9/L92/GET_COMP_SHELL_ALLOWS.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/TIMDAT.o obj/SCONTR.o obj/MACHINE_PARAMS.o obj/MODEL_STUF.o obj/SUBR_BEGEND_LEVELS.o obj/GET_COMP_SHELL_ALLOWS_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GP_FORCE_BALANCE_PROC.o: LK9/L92/GP_FORCE_BALANCE_PROC.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/DOF_TABLES.o obj/DEBUG_PARAMETERS.o obj/MODEL_STUF.o obj/LINK9_STUFF.o obj/COL_VECS.o obj/PARAMS.o obj/GP_FORCE_BALANCE_PROC_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/INDEP_FAILURE_INDEX.o: LK9/L92/INDEP_FAILURE_INDEX.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/MACHINE_PARAMS.o obj/DEBUG_PARAMETERS.o obj/PARAMS.o obj/MODEL_STUF.o obj/SUBR_BEGEND_LEVELS.o obj/INDEP_FAILURE_INDEX_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/OFP1.o: LK9/L92/OFP1.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/DOF_TABLES.o obj/MODEL_STUF.o obj/LINK9_STUFF.o obj/COL_VECS.o obj/OUTPUT4_MATRICES.o obj/CC_OUTPUT_DESCRIBERS.o obj/OFP1_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/OFP2.o: LK9/L92/OFP2.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/DOF_TABLES.o obj/EIGEN_MATRICES_1.o obj/MODEL_STUF.o obj/PARAMS.o obj/NONLINEAR_PARAMS.o obj/SPARSE_MATRICES.o obj/LINK9_STUFF.o obj/COL_VECS.o obj/DEBUG_PARAMETERS.o obj/OUTPUT4_MATRICES.o obj/CC_OUTPUT_DESCRIBERS.o obj/OFP2_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/OFP3.o: LK9/L92/OFP3.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/LINK9_STUFF.o obj/SUBR_BEGEND_LEVELS.o obj/OFP3_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/OFP3_ELFE_1D.o: LK9/L92/OFP3_ELFE_1D.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/FEMAP_ARRAYS.o obj/PARAMS.o obj/MODEL_STUF.o obj/LINK9_STUFF.o obj/OUTPUT4_MATRICES.o obj/OFP3_ELFE_1D_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/OFP3_ELFE_2D.o: LK9/L92/OFP3_ELFE_2D.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/FEMAP_ARRAYS.o obj/PARAMS.o obj/MODEL_STUF.o obj/LINK9_STUFF.o obj/OUTPUT4_MATRICES.o obj/OFP3_ELFE_2D_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/OFP3_ELFN.o: LK9/L92/OFP3_ELFN.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/PARAMS.o obj/MODEL_STUF.o obj/LINK9_STUFF.o obj/OUTPUT4_MATRICES.o obj/OFP3_ELFN_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/OFP3_STRE_NO_PCOMP.o: LK9/L92/OFP3_STRE_NO_PCOMP.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/FEMAP_ARRAYS.o obj/PARAMS.o obj/MODEL_STUF.o obj/CC_OUTPUT_DESCRIBERS.o obj/LINK9_STUFF.o obj/OUTPUT4_MATRICES.o obj/OFP3_STRE_NO_PCOMP_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/OFP3_STRE_PCOMP.o: LK9/L92/OFP3_STRE_PCOMP.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/FEMAP_ARRAYS.o obj/PARAMS.o obj/MODEL_STUF.o obj/LINK9_STUFF.o obj/OUTPUT4_MATRICES.o obj/OFP3_STRE_PCOMP_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/OFP3_STRN_NO_PCOMP.o: LK9/L92/OFP3_STRN_NO_PCOMP.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/FEMAP_ARRAYS.o obj/PARAMS.o obj/MODEL_STUF.o obj/CC_OUTPUT_DESCRIBERS.o obj/LINK9_STUFF.o obj/OUTPUT4_MATRICES.o obj/OFP3_STRN_NO_PCOMP_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/OFP3_STRN_PCOMP.o: LK9/L92/OFP3_STRN_PCOMP.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/FEMAP_ARRAYS.o obj/PARAMS.o obj/MODEL_STUF.o obj/LINK9_STUFF.o obj/OUTPUT4_MATRICES.o obj/OFP3_STRN_PCOMP_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ONE_D_STRAIN_OUTPUTS.o: LK9/L92/ONE_D_STRAIN_OUTPUTS.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/LINK9_STUFF.o obj/FEMAP_ARRAYS.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/ONE_D_STRAIN_OUTPUTS_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ONE_D_STRESS_OUTPUTS.o: LK9/L92/ONE_D_STRESS_OUTPUTS.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/LINK9_STUFF.o obj/FEMAP_ARRAYS.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/ONE_D_STRESS_OUTPUTS_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/POLYNOM_FIT_STRE_STRN.o: LK9/L92/POLYNOM_FIT_STRE_STRN.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/MODEL_STUF.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/POLYNOM_FIT_STRE_STRN_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/POLY_FAILURE_INDEX.o: LK9/L92/POLY_FAILURE_INDEX.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/MACHINE_PARAMS.o obj/DEBUG_PARAMETERS.o obj/PARAMS.o obj/MODEL_STUF.o obj/SUBR_BEGEND_LEVELS.o obj/POLY_FAILURE_INDEX_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SHELL_ENGR_FORCE_OGEL.o: LK9/L92/SHELL_ENGR_FORCE_OGEL.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/LINK9_STUFF.o obj/SHELL_ENGR_FORCE_OGEL_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SHELL_STRAIN_OUTPUTS.o: LK9/L92/SHELL_STRAIN_OUTPUTS.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/CC_OUTPUT_DESCRIBERS.o obj/LINK9_STUFF.o obj/FEMAP_ARRAYS.o obj/PARAMS.o obj/SHELL_STRAIN_OUTPUTS_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SHELL_STRESS_OUTPUTS.o: LK9/L92/SHELL_STRESS_OUTPUTS.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/CC_OUTPUT_DESCRIBERS.o obj/LINK9_STUFF.o obj/FEMAP_ARRAYS.o obj/PARAMS.o obj/SHELL_STRESS_OUTPUTS_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SOLID_STRAIN_OUTPUTS.o: LK9/L92/SOLID_STRAIN_OUTPUTS.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/CC_OUTPUT_DESCRIBERS.o obj/LINK9_STUFF.o obj/FEMAP_ARRAYS.o obj/PARAMS.o obj/SOLID_STRAIN_OUTPUTS_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SOLID_STRESS_OUTPUTS.o: LK9/L92/SOLID_STRESS_OUTPUTS.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/CC_OUTPUT_DESCRIBERS.o obj/LINK9_STUFF.o obj/FEMAP_ARRAYS.o obj/PARAMS.o obj/SOLID_STRESS_OUTPUTS_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/STR_TENSOR_TRANSFORM.o: LK9/L92/STR_TENSOR_TRANSFORM.f90 obj/PENTIUM_II_KIND.o obj/CONSTANTS_1.o obj/SCONTR.o obj/IOUNT1.o obj/TIMDAT.o obj/MODEL_STUF.o obj/SUBR_BEGEND_LEVELS.o obj/STR_TENSOR_TRANSFORM_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SUSER1.o: LK9/L92/SUSER1.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/SUSER1_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/TRANSFORM_NODE_FORCES.o: LK9/L92/TRANSFORM_NODE_FORCES.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/TRANSFORM_NODE_FORCES_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_FEMAP_DATA.o: LK9/LINK9/ALLOCATE_FEMAP_DATA.f90 obj/PENTIUM_II_KIND.o obj/CONSTANTS_1.o obj/SCONTR.o obj/IOUNT1.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/FEMAP_ARRAYS.o obj/ALLOCATE_FEMAP_DATA_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_LINK9_STUF.o: LK9/LINK9/ALLOCATE_LINK9_STUF.f90 obj/PENTIUM_II_KIND.o obj/CONSTANTS_1.o obj/SCONTR.o obj/IOUNT1.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/LINK9_STUFF.o obj/ALLOCATE_LINK9_STUF_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEALLOCATE_FEMAP_DATA.o: LK9/LINK9/DEALLOCATE_FEMAP_DATA.f90 obj/PENTIUM_II_KIND.o obj/SCONTR.o obj/IOUNT1.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/FEMAP_ARRAYS.o obj/DEALLOCATE_FEMAP_DATA_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEALLOCATE_LINK9_STUF.o: LK9/LINK9/DEALLOCATE_LINK9_STUF.f90 obj/PENTIUM_II_KIND.o obj/SCONTR.o obj/IOUNT1.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/LINK9_STUFF.o obj/DEALLOCATE_LINK9_STUF_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/LINK9.o: LK9/LINK9/LINK9.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/IOUNT1.o obj/IOUNT1.o obj/IOUNT1.o obj/IOUNT1.o obj/SCONTR.o obj/SCONTR.o obj/CC_OUTPUT_DESCRIBERS.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/NONLINEAR_PARAMS.o obj/COL_VECS.o obj/EIGEN_MATRICES_1.o obj/OUTPUT4_MATRICES.o obj/OUTPUT4_MATRICES.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/DOF_TABLES.o obj/MODEL_STUF.o obj/LINK9_STUFF.o obj/DEBUG_PARAMETERS.o obj/LINK9_USE_IFs.o obj/PENTIUM_II_KIND.o obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/SPARSE_MATRICES.o obj/EIGEN_MATRICES_1.o obj/DOF_TABLES.o obj/COL_VECS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/LINK9S.o: LK9/LINK9/LINK9S.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/LINK9S_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MAXREQ_OGEL.o: LK9/LINK9/MAXREQ_OGEL.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/CC_OUTPUT_DESCRIBERS.o obj/LINK9_STUFF.o obj/DEBUG_PARAMETERS.o obj/MAXREQ_OGEL_USE_IFs.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_INI_FILNAM.o: MAIN/GET_INI_FILNAM.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/GET_INI_FILNAM_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_MYSTRAN_DIR.o: MAIN/GET_MYSTRAN_DIR.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/GET_MYSTRAN_DIR_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MYSTRAN.o: MAIN/MYSTRAN.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/NONLINEAR_PARAMS.o obj/PARAMS.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/MYSTRAN_Version.o obj/OUTPUT4_MATRICES.o obj/COL_VECS.o obj/MYSTRAN_USE_IFs.o obj/SCONTR.o obj/CONSTANTS_1.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MYSTRAN_FILES.o: MAIN/MYSTRAN_FILES.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/IOUNT1.o obj/IOUNT1.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MYSTRAN_FILES_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/PROCESS_INCLUDE_FILES.o: MAIN/PROCESS_INCLUDE_FILES.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/PROCESS_INCLUDE_FILES_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/READ_INI.o: MAIN/READ_INI.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/IOUNT1.o obj/IOUNT1.o obj/SCONTR.o obj/READ_INI_USE_IFs.o obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/PENTIUM_II_KIND.o obj/SCONTR.o obj/PENTIUM_II_KIND.o obj/SCONTR.o obj/PENTIUM_II_KIND.o obj/SCONTR.o obj/IOUNT1.o obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/PENTIUM_II_KIND.o obj/iount1.o
	$(F77) $(FLAGS) -c $< -o $@
obj/READ_INPUT_FILE_NAME.o: MAIN/READ_INPUT_FILE_NAME.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/READ_INPUT_FILE_NAME_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATED_ARRAY_DATA.o: Modules/ALLOCATED_ARRAY_DATA.f90 obj/PENTIUM_II_KIND.o obj/CONSTANTS_1.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ARPACK_MATRICES_1.o: Modules/ARPACK_MATRICES_1.f90 obj/PENTIUM_II_KIND.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_OUTPUT_DESCRIBERS.o: Modules/CC_OUTPUT_DESCRIBERS.f90 obj/PENTIUM_II_KIND.o obj/SCONTR.o
	$(F77) $(FLAGS) -c $< -o $@
obj/COL_VECS.o: Modules/COL_VECS.f90 obj/PENTIUM_II_KIND.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CONSTANTS_1.o: Modules/CONSTANTS_1.f90 obj/PENTIUM_II_KIND.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CONSTANTS_GAUSS.o: Modules/CONSTANTS_GAUSS.f90 obj/PENTIUM_II_KIND.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEBUG_PARAMETERS.o: Modules/DEBUG_PARAMETERS.f90 obj/PENTIUM_II_KIND.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DERIVED_DATA_TYPES.o: Modules/DERIVED_DATA_TYPES.f90 obj/PENTIUM_II_KIND.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DOF_TABLES.o: Modules/DOF_TABLES.f90 obj/PENTIUM_II_KIND.o obj/SCONTR.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DRIVE_CRS_CCS_Module.o: Modules/DRIVE_CRS_CCS_Module.f90 obj/PENTIUM_II_KIND.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DRIVE_INVERT_FF_MAT_Module.o: Modules/DRIVE_INVERT_FF_MAT_Module.f90 obj/PENTIUM_II_KIND.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DRIVE_MATADD_SSS_Module.o: Modules/DRIVE_MATADD_SSS_Module.f90 obj/PENTIUM_II_KIND.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DRIVE_MATMULT_SFF_Module.o: Modules/DRIVE_MATMULT_SFF_Module.f90 obj/PENTIUM_II_KIND.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DRIVE_MATMULT_SFS_Module.o: Modules/DRIVE_MATMULT_SFS_Module.f90 obj/PENTIUM_II_KIND.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DRIVE_MATMULT_SSS_Module.o: Modules/DRIVE_MATMULT_SSS_Module.f90 obj/PENTIUM_II_KIND.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DRIVE_MATTRNSP_SS_Module.o: Modules/DRIVE_MATTRNSP_SS_Module.f90 obj/PENTIUM_II_KIND.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DRIVE_PARTITION_SS_Module.o: Modules/DRIVE_PARTITION_SS_Module.f90 obj/PENTIUM_II_KIND.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DRIVE_SPARSE_ZEROS_Module.o: Modules/DRIVE_SPARSE_ZEROS_Module.f90 obj/PENTIUM_II_KIND.o
	$(F77) $(FLAGS) -c $< -o $@
obj/EIGEN_MATRICES_1.o: Modules/EIGEN_MATRICES_1.f90 obj/PENTIUM_II_KIND.o
	$(F77) $(FLAGS) -c $< -o $@
obj/EMS_ARRAYS.o: Modules/EMS_ARRAYS.f90 obj/PENTIUM_II_KIND.o
	$(F77) $(FLAGS) -c $< -o $@
obj/FEMAP_ARRAYS.o: Modules/FEMAP_ARRAYS.f90 obj/PENTIUM_II_KIND.o
	$(F77) $(FLAGS) -c $< -o $@
obj/FULL_MATRICES.o: Modules/FULL_MATRICES.f90 obj/PENTIUM_II_KIND.o
	$(F77) $(FLAGS) -c $< -o $@
obj/INPUTT4_MATRICES.o: Modules/INPUTT4_MATRICES.f90 obj/PENTIUM_II_KIND.o
	$(F77) $(FLAGS) -c $< -o $@
obj/IOUNT1.o: Modules/IOUNT1.f90 obj/PENTIUM_II_KIND.o obj/SCONTR.o
	$(F77) $(FLAGS) -c $< -o $@
obj/LAPACK_DPB_MATRICES.o: Modules/LAPACK_DPB_MATRICES.f90 obj/PENTIUM_II_KIND.o
	$(F77) $(FLAGS) -c $< -o $@
obj/LINK9_STUFF.o: Modules/LINK9_STUFF.f90 obj/PENTIUM_II_KIND.o
	$(F77) $(FLAGS) -c $< -o $@
obj/LSQ_MYSTRAN.o: Modules/LSQ_MYSTRAN.f90
	$(F77) $(FLAGS) -c $< -o $@
obj/MACHINE_PARAMS.o: Modules/MACHINE_PARAMS.f90 obj/PENTIUM_II_KIND.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MISC_MATRICES.o: Modules/MISC_MATRICES.f90 obj/PENTIUM_II_KIND.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MODEL_STUF.o: Modules/MODEL_STUF.f90 obj/PENTIUM_II_KIND.o obj/CONSTANTS_1.o obj/SCONTR.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MYSTRAN_Version.o: Modules/MYSTRAN_Version.f90 obj/PENTIUM_II_KIND.o
	$(F77) $(FLAGS) -c $< -o $@
obj/NONLINEAR_PARAMS.o: Modules/NONLINEAR_PARAMS.f90 obj/PENTIUM_II_KIND.o
	$(F77) $(FLAGS) -c $< -o $@
obj/OUTPUT4_MATRICES.o: Modules/OUTPUT4_MATRICES.f90 obj/PENTIUM_II_KIND.o obj/SCONTR.o
	$(F77) $(FLAGS) -c $< -o $@
obj/PARAMS.o: Modules/PARAMS.f90 obj/PENTIUM_II_KIND.o obj/CONSTANTS_1.o obj/SCONTR.o
	$(F77) $(FLAGS) -c $< -o $@
obj/PENTIUM_II_KIND.o: Modules/PENTIUM_II_KIND.f90
	$(F77) $(FLAGS) -c $< -o $@
obj/RIGID_BODY_DISP_MATS.o: Modules/RIGID_BODY_DISP_MATS.f90 obj/PENTIUM_II_KIND.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SCONTR.o: Modules/SCONTR.f90 obj/PENTIUM_II_KIND.o obj/CONSTANTS_1.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SCRATCH_MATRICES.o: Modules/SCRATCH_MATRICES.f90 obj/PENTIUM_II_KIND.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SPARSE_ALG_ARRAYS.o: Modules/SPARSE_ALG_ARRAYS.f90 obj/PENTIUM_II_KIND.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SPARSE_MATRICES.o: Modules/SPARSE_MATRICES.f90 obj/PENTIUM_II_KIND.o
	$(F77) $(FLAGS) -c $< -o $@
obj/STF_ARRAYS.o: Modules/STF_ARRAYS.f90 obj/PENTIUM_II_KIND.o obj/DERIVED_DATA_TYPES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/STF_TEMPLATE_ARRAYS.o: Modules/STF_TEMPLATE_ARRAYS.f90 obj/PENTIUM_II_KIND.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SUBR_BEGEND_LEVELS.o: Modules/SUBR_BEGEND_LEVELS.f90 obj/PENTIUM_II_KIND.o
	$(F77) $(FLAGS) -c $< -o $@
obj/TIMDAT.o: Modules/TIMDAT.f90 obj/PENTIUM_II_KIND.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ARPACK_LANCZOS_EIG.o: Modules/ARPACK/ARPACK_LANCZOS_EIG.f obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/MODEL_STUF.o obj/SUBR_BEGEND_LEVELS.o obj/ARPACK_UTIL.o obj/LAPACK_BLAS_AUX.o obj/LAPACK_LANCZOS_EIG.o obj/LAPACK_MISCEL.o obj/LAPACK_LIN_EQN_DGB.o obj/LAPACK_LIN_EQN_DPB.o obj/OURTIM_Interface.o obj/MATMULT_SFF_Interface.o obj/ARPACK_INFO_MSG_Interface.o obj/SCONTR.o obj/SPARSE_MATRICES.o obj/MODEL_STUF.o obj/PENTIUM_II_KIND.o obj/SCONTR.o obj/IOUNT1.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ARPACK_UTIL.o: Modules/ARPACK/ARPACK_UTIL.f obj/IOUNT1.o obj/PENTIUM_II_KIND.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BANDIT_BLOCK_DATA.o: Modules/Bandit/BANDIT_BLOCK_DATA.f90
	$(F77) $(FLAGS) -c $< -o $@
obj/BANDIT_MODULE.o: Modules/Bandit/BANDIT_MODULE.f obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/IOUNT1.o obj/IOUNT1.o obj/IOUNT1.o obj/BANDIT_BLOCK_DATA.o
	$(F77) $(FLAGS) -c $< -o $@
obj/LAPACK_BLAS_AUX.o: Modules/LAPACK/LAPACK_BLAS_AUX.f obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/OUTA_HERE_Interface.o obj/PENTIUM_II_KIND.o obj/PENTIUM_II_KIND.o
	$(F77) $(FLAGS) -c $< -o $@
obj/LAPACK_GIV_MGIV_EIG.o: Modules/LAPACK/LAPACK_GIV_MGIV_EIG.f obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/LAPACK_BLAS_AUX.o obj/LAPACK_MISCEL.o obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o obj/PENTIUM_II_KIND.o obj/PARAMS.o obj/SCONTR.o obj/PARAMS.o obj/PENTIUM_II_KIND.o obj/PENTIUM_II_KIND.o obj/PENTIUM_II_KIND.o obj/PENTIUM_II_KIND.o obj/PENTIUM_II_KIND.o
	$(F77) $(FLAGS) -c $< -o $@
obj/LAPACK_LANCZOS_EIG.o: Modules/LAPACK/LAPACK_LANCZOS_EIG.f obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/LAPACK_BLAS_AUX.o obj/SUBR_BEGEND_LEVELS.o obj/OURTIM_Interface.o obj/PENTIUM_II_KIND.o obj/PENTIUM_II_KIND.o
	$(F77) $(FLAGS) -c $< -o $@
obj/LAPACK_LIN_EQN_DGB.o: Modules/LAPACK/LAPACK_LIN_EQN_DGB.f obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/LAPACK_BLAS_AUX.o obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o obj/PENTIUM_II_KIND.o obj/PENTIUM_II_KIND.o obj/PENTIUM_II_KIND.o
	$(F77) $(FLAGS) -c $< -o $@
obj/LAPACK_LIN_EQN_DGE.o: Modules/LAPACK/LAPACK_LIN_EQN_DGE.f obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/LAPACK_BLAS_AUX.o obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o obj/PENTIUM_II_KIND.o obj/PENTIUM_II_KIND.o obj/PENTIUM_II_KIND.o obj/PENTIUM_II_KIND.o
	$(F77) $(FLAGS) -c $< -o $@
obj/LAPACK_LIN_EQN_DPB.o: Modules/LAPACK/LAPACK_LIN_EQN_DPB.f obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/LAPACK_BLAS_AUX.o obj/PENTIUM_II_KIND.o obj/PENTIUM_II_KIND.o obj/PENTIUM_II_KIND.o obj/PENTIUM_II_KIND.o obj/PENTIUM_II_KIND.o obj/PENTIUM_II_KIND.o
	$(F77) $(FLAGS) -c $< -o $@
obj/LAPACK_MISCEL.o: Modules/LAPACK/LAPACK_MISCEL.f obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/LAPACK_BLAS_AUX.o obj/LAPACK_LIN_EQN_DPB.o obj/OURTIM_Interface.o obj/PENTIUM_II_KIND.o obj/PENTIUM_II_KIND.o
	$(F77) $(FLAGS) -c $< -o $@
obj/LAPACK_STD_EIG_1.o: Modules/LAPACK/LAPACK_STD_EIG_1.f obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/LAPACK_BLAS_AUX.o obj/LAPACK_MISCEL.o obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o obj/PENTIUM_II_KIND.o obj/PENTIUM_II_KIND.o obj/PENTIUM_II_KIND.o
	$(F77) $(FLAGS) -c $< -o $@
obj/LAPACK_SYM_MAT_INV.o: Modules/LAPACK/LAPACK_SYM_MAT_INV.f obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/LAPACK_BLAS_AUX.o obj/LAPACK_LIN_EQN_DPB.o obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATED_MEMORY_USE_IFs.o: USE_IFs/ALLOCATED_MEMORY_USE_IFs.f90 obj/OUTA_HERE_Interface.o obj/WRITE_ALLOC_MEM_TABLE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_CB_ELM_OTM_USE_IFs.o: USE_IFs/ALLOCATE_CB_ELM_OTM_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o obj/ALLOCATED_MEMORY_Interface.o obj/WRITE_MEM_SUM_TO_F04_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_CB_GRD_OTM_USE_IFs.o: USE_IFs/ALLOCATE_CB_GRD_OTM_USE_IFs.f90 obj/OURTIM_Interface.o obj/ALLOCATED_MEMORY_Interface.o obj/WRITE_MEM_SUM_TO_F04_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_COL_VEC_USE_IFs.o: USE_IFs/ALLOCATE_COL_VEC_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o obj/ALLOCATED_MEMORY_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_DOF_TABLES_USE_IFs.o: USE_IFs/ALLOCATE_DOF_TABLES_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o obj/ALLOCATED_MEMORY_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_EIGEN1_MAT_USE_IFs.o: USE_IFs/ALLOCATE_EIGEN1_MAT_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o obj/ALLOCATED_MEMORY_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_EMS_ARRAYS_USE_IFs.o: USE_IFs/ALLOCATE_EMS_ARRAYS_USE_IFs.f90 obj/OURTIM_Interface.o obj/ALLOCATED_MEMORY_Interface.o obj/WRITE_MEM_SUM_TO_F04_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_FEMAP_DATA_USE_IFs.o: USE_IFs/ALLOCATE_FEMAP_DATA_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o obj/ALLOCATED_MEMORY_Interface.o obj/WRITE_MEM_SUM_TO_F04_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_FULL_MAT_USE_IFs.o: USE_IFs/ALLOCATE_FULL_MAT_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o obj/ALLOCATED_MEMORY_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_IN4_FILES_USE_IFs.o: USE_IFs/ALLOCATE_IN4_FILES_USE_IFs.f90 obj/OURTIM_Interface.o obj/ALLOCATED_MEMORY_Interface.o obj/WRITE_MEM_SUM_TO_F04_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_L1_MGG_USE_IFs.o: USE_IFs/ALLOCATE_L1_MGG_USE_IFs.f90 obj/OURTIM_Interface.o obj/ALLOCATED_MEMORY_Interface.o obj/WRITE_MEM_SUM_TO_F04_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_L2_GMN_2_USE_IFs.o: USE_IFs/ALLOCATE_L2_GMN_2_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o obj/ALLOCATED_MEMORY_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_L2_GOA_2_USE_IFs.o: USE_IFs/ALLOCATE_L2_GOA_2_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o obj/ALLOCATED_MEMORY_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_L6_2_USE_IFs.o: USE_IFs/ALLOCATE_L6_2_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o obj/ALLOCATED_MEMORY_Interface.o obj/WRITE_MEM_SUM_TO_F04_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_LAPACK_MAT_USE_IFs.o: USE_IFs/ALLOCATE_LAPACK_MAT_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o obj/ALLOCATED_MEMORY_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_LINK9_STUF_USE_IFs.o: USE_IFs/ALLOCATE_LINK9_STUF_USE_IFs.f90 obj/OURTIM_Interface.o obj/ALLOCATED_MEMORY_Interface.o obj/WRITE_MEM_SUM_TO_F04_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_MISC_MAT_USE_IFs.o: USE_IFs/ALLOCATE_MISC_MAT_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o obj/ALLOCATED_MEMORY_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_MODEL_STUF_USE_IFs.o: USE_IFs/ALLOCATE_MODEL_STUF_USE_IFs.f90 obj/OURTIM_Interface.o obj/ALLOCATED_MEMORY_Interface.o obj/WRITE_MEM_SUM_TO_F04_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_NL_PARAMS_USE_IFs.o: USE_IFs/ALLOCATE_NL_PARAMS_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o obj/ALLOCATED_MEMORY_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_RBGLOBAL_USE_IFs.o: USE_IFs/ALLOCATE_RBGLOBAL_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o obj/ALLOCATED_MEMORY_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_SCR_CCS_MAT_USE_IFs.o: USE_IFs/ALLOCATE_SCR_CCS_MAT_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o obj/ALLOCATED_MEMORY_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_SCR_CRS_MAT_USE_IFs.o: USE_IFs/ALLOCATE_SCR_CRS_MAT_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o obj/ALLOCATED_MEMORY_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_SPARSE_ALG_USE_IFs.o: USE_IFs/ALLOCATE_SPARSE_ALG_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o obj/ALLOCATED_MEMORY_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_SPARSE_MAT_USE_IFs.o: USE_IFs/ALLOCATE_SPARSE_MAT_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o obj/ALLOCATED_MEMORY_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_STF_ARRAYS_USE_IFs.o: USE_IFs/ALLOCATE_STF_ARRAYS_USE_IFs.f90 obj/OURTIM_Interface.o obj/ALLOCATED_MEMORY_Interface.o obj/WRITE_MEM_SUM_TO_F04_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_TEMPLATE_USE_IFs.o: USE_IFs/ALLOCATE_TEMPLATE_USE_IFs.f90 obj/OURTIM_Interface.o obj/ALLOCATED_MEMORY_Interface.o obj/WRITE_MEM_SUM_TO_F04_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ARPACK_INFO_MSG_USE_IFs.o: USE_IFs/ARPACK_INFO_MSG_USE_IFs.f90
	$(F77) $(FLAGS) -c $< -o $@
obj/ARRAY_SIZE_ERROR_1_USE_IFs.o: USE_IFs/ARRAY_SIZE_ERROR_1_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/AUTOSPC_SUMMARY_MSGS_USE_IFs.o: USE_IFs/AUTOSPC_SUMMARY_MSGS_USE_IFs.f90
	$(F77) $(FLAGS) -c $< -o $@
obj/B3D_ISOPARAMETRIC_USE_IFs.o: USE_IFs/B3D_ISOPARAMETRIC_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BANDGEN_LAPACK_DGB_USE_IFs.o: USE_IFs/BANDGEN_LAPACK_DGB_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BANDGEN_LAPACK_DPB_USE_IFs.o: USE_IFs/BANDGEN_LAPACK_DPB_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BANDIT_FILES_USE_IFs.o: USE_IFs/BANDIT_FILES_USE_IFs.f90 obj/FILE_OPEN_Interface.o obj/FILE_CLOSE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BANDSIZ_USE_IFs.o: USE_IFs/BANDSIZ_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BAR1_USE_IFs.o: USE_IFs/BAR1_USE_IFs.f90 obj/OURTIM_Interface.o obj/PINFLG_Interface.o obj/MATMULT_FFF_Interface.o obj/ELMDIS_Interface.o obj/CALC_ELEM_NODE_FORCES_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BAR_MARGIN_USE_IFs.o: USE_IFs/BAR_MARGIN_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BBDKQ_USE_IFs.o: USE_IFs/BBDKQ_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BBMIN3_USE_IFs.o: USE_IFs/BBMIN3_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BBMIN4_USE_IFs.o: USE_IFs/BBMIN4_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BCHECK_2D_USE_IFs.o: USE_IFs/BCHECK_2D_USE_IFs.f90 obj/OURTIM_Interface.o obj/RIGID_BODY_DISP_MAT_Interface.o obj/MATMULT_FFF_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BCHECK_3D_USE_IFs.o: USE_IFs/BCHECK_3D_USE_IFs.f90 obj/OURTIM_Interface.o obj/RIGID_BODY_DISP_MAT_Interface.o obj/MATMULT_FFF_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_ASET1_USE_IFs.o: USE_IFs/BD_ASET1_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/TOKCHK_Interface.o obj/IP6CHK_Interface.o obj/I4FLD_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CARD_FLDS_NOT_BLANK_Interface.o obj/CRDERR_Interface.o obj/NEXTC_Interface.o obj/NEXTC2_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_ASET_USE_IFs.o: USE_IFs/BD_ASET_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/I4FLD_Interface.o obj/IP6CHK_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CRDERR_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_BAROR0_USE_IFs.o: USE_IFs/BD_BAROR0_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/I4FLD_Interface.o obj/R8FLD_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_BAROR_USE_IFs.o: USE_IFs/BD_BAROR_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/I4FLD_Interface.o obj/R8FLD_Interface.o obj/CARD_FLDS_NOT_BLANK_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CRDERR_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_BEAMOR0_USE_IFs.o: USE_IFs/BD_BEAMOR0_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/I4FLD_Interface.o obj/R8FLD_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_BEAMOR_USE_IFs.o: USE_IFs/BD_BEAMOR_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/I4FLD_Interface.o obj/R8FLD_Interface.o obj/CARD_FLDS_NOT_BLANK_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CRDERR_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CBAR0_USE_IFs.o: USE_IFs/BD_CBAR0_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/NEXTC0_Interface.o obj/NEXTC20_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CBAR_USE_IFs.o: USE_IFs/BD_CBAR_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/ELEPRO_Interface.o obj/R8FLD_Interface.o obj/I4FLD_Interface.o obj/OUTA_HERE_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CARD_FLDS_NOT_BLANK_Interface.o obj/CRDERR_Interface.o obj/NEXTC_Interface.o obj/NEXTC2_Interface.o obj/IP6CHK_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CBUSH0_USE_IFs.o: USE_IFs/BD_CBUSH0_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/NEXTC0_Interface.o obj/NEXTC20_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CBUSH_USE_IFs.o: USE_IFs/BD_CBUSH_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/LEFT_ADJ_BDFLD_Interface.o obj/ELEPRO_Interface.o obj/R8FLD_Interface.o obj/I4FLD_Interface.o obj/OUTA_HERE_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CRDERR_Interface.o obj/NEXTC_Interface.o obj/NEXTC2_Interface.o obj/CARD_FLDS_NOT_BLANK_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CELAS1_USE_IFs.o: USE_IFs/BD_CELAS1_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/ELEPRO_Interface.o obj/I4FLD_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CARD_FLDS_NOT_BLANK_Interface.o obj/CRDERR_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CELAS2_USE_IFs.o: USE_IFs/BD_CELAS2_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/I4FLD_Interface.o obj/R8FLD_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CRDERR_Interface.o obj/ELEPRO_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CELAS3_USE_IFs.o: USE_IFs/BD_CELAS3_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/ELEPRO_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CARD_FLDS_NOT_BLANK_Interface.o obj/CRDERR_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CELAS4_USE_IFs.o: USE_IFs/BD_CELAS4_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/I4FLD_Interface.o obj/R8FLD_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CARD_FLDS_NOT_BLANK_Interface.o obj/CRDERR_Interface.o obj/ELEPRO_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CHEXA0_USE_IFs.o: USE_IFs/BD_CHEXA0_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/NEXTC0_Interface.o obj/NEXTC20_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CHEXA_USE_IFs.o: USE_IFs/BD_CHEXA_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/ELEPRO_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CRDERR_Interface.o obj/NEXTC_Interface.o obj/NEXTC2_Interface.o obj/CARD_FLDS_NOT_BLANK_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CMASS1_USE_IFs.o: USE_IFs/BD_CMASS1_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/I4FLD_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CARD_FLDS_NOT_BLANK_Interface.o obj/CRDERR_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CMASS2_USE_IFs.o: USE_IFs/BD_CMASS2_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/I4FLD_Interface.o obj/R8FLD_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CARD_FLDS_NOT_BLANK_Interface.o obj/CRDERR_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CMASS3_USE_IFs.o: USE_IFs/BD_CMASS3_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/I4FLD_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CARD_FLDS_NOT_BLANK_Interface.o obj/CRDERR_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CMASS4_USE_IFs.o: USE_IFs/BD_CMASS4_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/I4FLD_Interface.o obj/R8FLD_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CARD_FLDS_NOT_BLANK_Interface.o obj/CRDERR_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CONM2_USE_IFs.o: USE_IFs/BD_CONM2_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/I4FLD_Interface.o obj/R8FLD_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CARD_FLDS_NOT_BLANK_Interface.o obj/CRDERR_Interface.o obj/NEXTC_Interface.o obj/NEXTC2_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CONROD_USE_IFs.o: USE_IFs/BD_CONROD_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/I4FLD_Interface.o obj/R8FLD_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CRDERR_Interface.o obj/ELEPRO_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CORD_USE_IFs.o: USE_IFs/BD_CORD_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/I4FLD_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CARD_FLDS_NOT_BLANK_Interface.o obj/CRDERR_Interface.o obj/R8FLD_Interface.o obj/NEXTC_Interface.o obj/NEXTC2_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CPENTA0_USE_IFs.o: USE_IFs/BD_CPENTA0_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/NEXTC0_Interface.o obj/NEXTC20_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CPENTA_USE_IFs.o: USE_IFs/BD_CPENTA_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/ELEPRO_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CRDERR_Interface.o obj/NEXTC_Interface.o obj/NEXTC2_Interface.o obj/CARD_FLDS_NOT_BLANK_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CQUAD0_USE_IFs.o: USE_IFs/BD_CQUAD0_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/NEXTC0_Interface.o obj/NEXTC20_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CQUAD_USE_IFs.o: USE_IFs/BD_CQUAD_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/ELEPRO_Interface.o obj/TOKCHK_Interface.o obj/OUTA_HERE_Interface.o obj/R8FLD_Interface.o obj/I4FLD_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CRDERR_Interface.o obj/NEXTC_Interface.o obj/NEXTC2_Interface.o obj/CARD_FLDS_NOT_BLANK_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CROD_USE_IFs.o: USE_IFs/BD_CROD_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/ELEPRO_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CARD_FLDS_NOT_BLANK_Interface.o obj/CRDERR_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CSHEAR_USE_IFs.o: USE_IFs/BD_CSHEAR_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/ELEPRO_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CARD_FLDS_NOT_BLANK_Interface.o obj/CRDERR_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CTETRA0_USE_IFs.o: USE_IFs/BD_CTETRA0_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/NEXTC0_Interface.o obj/NEXTC20_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CTETRA_USE_IFs.o: USE_IFs/BD_CTETRA_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/ELEPRO_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CARD_FLDS_NOT_BLANK_Interface.o obj/CRDERR_Interface.o obj/NEXTC_Interface.o obj/NEXTC2_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CTRIA0_USE_IFs.o: USE_IFs/BD_CTRIA0_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/NEXTC0_Interface.o obj/NEXTC20_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CTRIA_USE_IFs.o: USE_IFs/BD_CTRIA_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/ELEPRO_Interface.o obj/TOKCHK_Interface.o obj/OUTA_HERE_Interface.o obj/R8FLD_Interface.o obj/I4FLD_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CARD_FLDS_NOT_BLANK_Interface.o obj/CRDERR_Interface.o obj/NEXTC_Interface.o obj/NEXTC2_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CUSER1_USE_IFs.o: USE_IFs/BD_CUSER1_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/ELEPRO_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CARD_FLDS_NOT_BLANK_Interface.o obj/CRDERR_Interface.o obj/NEXTC_Interface.o obj/NEXTC2_Interface.o obj/I4FLD_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CUSERIN0_USE_IFs.o: USE_IFs/BD_CUSERIN0_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/I4FLD_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_CUSERIN_USE_IFs.o: USE_IFs/BD_CUSERIN_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/I4FLD_Interface.o obj/ELEPRO_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CARD_FLDS_NOT_BLANK_Interface.o obj/CRDERR_Interface.o obj/NEXTC_Interface.o obj/NEXTC2_Interface.o obj/IP6CHK_Interface.o obj/TOKCHK_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_DEBUG0_USE_IFs.o: USE_IFs/BD_DEBUG0_USE_IFs.f90 obj/MKJCARD_Interface.o obj/I4FLD_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_DEBUG_USE_IFs.o: USE_IFs/BD_DEBUG_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/I4FLD_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CARD_FLDS_NOT_BLANK_Interface.o obj/CRDERR_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_EIGRL_USE_IFs.o: USE_IFs/BD_EIGRL_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/I4FLD_Interface.o obj/R8FLD_Interface.o obj/CHAR_FLD_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CRDERR_Interface.o obj/NEXTC_Interface.o obj/NEXTC2_Interface.o obj/LEFT_ADJ_BDFLD_Interface.o obj/CARD_FLDS_NOT_BLANK_Interface.o obj/WRITE_L1M_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_EIGR_USE_IFs.o: USE_IFs/BD_EIGR_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/I4FLD_Interface.o obj/LEFT_ADJ_BDFLD_Interface.o obj/CHAR_FLD_Interface.o obj/R8FLD_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CRDERR_Interface.o obj/NEXTC_Interface.o obj/NEXTC2_Interface.o obj/CARD_FLDS_NOT_BLANK_Interface.o obj/WRITE_L1M_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_FORMOM_USE_IFs.o: USE_IFs/BD_FORMOM_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/I4FLD_Interface.o obj/R8FLD_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CARD_FLDS_NOT_BLANK_Interface.o obj/CRDERR_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_GRAV_USE_IFs.o: USE_IFs/BD_GRAV_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/I4FLD_Interface.o obj/R8FLD_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CARD_FLDS_NOT_BLANK_Interface.o obj/CRDERR_Interface.o obj/NEXTC_Interface.o obj/NEXTC2_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_GRDSET0_USE_IFs.o: USE_IFs/BD_GRDSET0_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/I4FLD_Interface.o obj/IP6CHK_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_GRDSET_USE_IFs.o: USE_IFs/BD_GRDSET_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/I4FLD_Interface.o obj/IP6CHK_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CARD_FLDS_NOT_BLANK_Interface.o obj/CRDERR_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_GRID_USE_IFs.o: USE_IFs/BD_GRID_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/I4FLD_Interface.o obj/R8FLD_Interface.o obj/IP6CHK_Interface.o obj/TOKCHK_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CARD_FLDS_NOT_BLANK_Interface.o obj/CRDERR_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_IMBEDDED_BLANK_USE_IFs.o: USE_IFs/BD_IMBEDDED_BLANK_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_LOAD0_USE_IFs.o: USE_IFs/BD_LOAD0_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/NEXTC0_Interface.o obj/NEXTC20_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_LOAD_USE_IFs.o: USE_IFs/BD_LOAD_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/I4FLD_Interface.o obj/R8FLD_Interface.o obj/OUTA_HERE_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CRDERR_Interface.o obj/NEXTC_Interface.o obj/NEXTC2_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_MAT1_USE_IFs.o: USE_IFs/BD_MAT1_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/OUTA_HERE_Interface.o obj/I4FLD_Interface.o obj/R8FLD_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CRDERR_Interface.o obj/NEXTC_Interface.o obj/NEXTC2_Interface.o obj/CARD_FLDS_NOT_BLANK_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_MAT2_USE_IFs.o: USE_IFs/BD_MAT2_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/OUTA_HERE_Interface.o obj/I4FLD_Interface.o obj/R8FLD_Interface.o obj/NEXTC_Interface.o obj/NEXTC2_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CRDERR_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_MAT8_USE_IFs.o: USE_IFs/BD_MAT8_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/OUTA_HERE_Interface.o obj/I4FLD_Interface.o obj/R8FLD_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CRDERR_Interface.o obj/NEXTC_Interface.o obj/NEXTC2_Interface.o obj/CARD_FLDS_NOT_BLANK_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_MAT9_USE_IFs.o: USE_IFs/BD_MAT9_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/OUTA_HERE_Interface.o obj/I4FLD_Interface.o obj/R8FLD_Interface.o obj/NEXTC_Interface.o obj/NEXTC2_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CRDERR_Interface.o obj/CARD_FLDS_NOT_BLANK_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_MPC0_USE_IFs.o: USE_IFs/BD_MPC0_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/NEXTC0_Interface.o obj/NEXTC20_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_MPCADD0_USE_IFs.o: USE_IFs/BD_MPCADD0_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/NEXTC0_Interface.o obj/NEXTC20_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_MPCADD_USE_IFs.o: USE_IFs/BD_MPCADD_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/I4FLD_Interface.o obj/OUTA_HERE_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CRDERR_Interface.o obj/NEXTC_Interface.o obj/NEXTC2_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_MPC_USE_IFs.o: USE_IFs/BD_MPC_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/I4FLD_Interface.o obj/OUTA_HERE_Interface.o obj/R8FLD_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CARD_FLDS_NOT_BLANK_Interface.o obj/CRDERR_Interface.o obj/NEXTC_Interface.o obj/NEXTC2_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_NLPARM_USE_IFs.o: USE_IFs/BD_NLPARM_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/I4FLD_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CARD_FLDS_NOT_BLANK_Interface.o obj/CRDERR_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_PARAM0_USE_IFs.o: USE_IFs/BD_PARAM0_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/LEFT_ADJ_BDFLD_Interface.o obj/I4FLD_Interface.o obj/CHAR_FLD_Interface.o obj/R8FLD_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_PARAM_USE_IFs.o: USE_IFs/BD_PARAM_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/R8FLD_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CARD_FLDS_NOT_BLANK_Interface.o obj/CRDERR_Interface.o obj/CHAR_FLD_Interface.o obj/LEFT_ADJ_BDFLD_Interface.o obj/I4FLD_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_PARVEC1_USE_IFs.o: USE_IFs/BD_PARVEC1_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/CHAR_FLD_Interface.o obj/LEFT_ADJ_BDFLD_Interface.o obj/IP6CHK_Interface.o obj/I4FLD_Interface.o obj/TOKCHK_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CARD_FLDS_NOT_BLANK_Interface.o obj/CRDERR_Interface.o obj/NEXTC_Interface.o obj/NEXTC2_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_PARVEC_USE_IFs.o: USE_IFs/BD_PARVEC_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/CHAR_FLD_Interface.o obj/LEFT_ADJ_BDFLD_Interface.o obj/I4FLD_Interface.o obj/IP6CHK_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CARD_FLDS_NOT_BLANK_Interface.o obj/CRDERR_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_PBARL_USE_IFs.o: USE_IFs/BD_PBARL_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/OUTA_HERE_Interface.o obj/I4FLD_Interface.o obj/LEFT_ADJ_BDFLD_Interface.o obj/CHAR_FLD_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CARD_FLDS_NOT_BLANK_Interface.o obj/CRDERR_Interface.o obj/NEXTC_Interface.o obj/NEXTC2_Interface.o obj/R8FLD_Interface.o obj/CHECK_BAR_MOIs_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_PBAR_USE_IFs.o: USE_IFs/BD_PBAR_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/I4FLD_Interface.o obj/R8FLD_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CARD_FLDS_NOT_BLANK_Interface.o obj/CRDERR_Interface.o obj/NEXTC_Interface.o obj/NEXTC2_Interface.o obj/CHECK_BAR_MOIs_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_PBEAM_USE_IFs.o: USE_IFs/BD_PBEAM_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/I4FLD_Interface.o obj/R8FLD_Interface.o obj/CHECK_BAR_MOIs_Interface.o obj/NEXTC_Interface.o obj/NEXTC2_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CRDERR_Interface.o obj/CHAR_FLD_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_PBUSH_USE_IFs.o: USE_IFs/BD_PBUSH_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/I4FLD_Interface.o obj/LEFT_ADJ_BDFLD_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CARD_FLDS_NOT_BLANK_Interface.o obj/R8FLD_Interface.o obj/CRDERR_Interface.o obj/NEXTC_Interface.o obj/NEXTC2_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_PCOMP0_USE_IFs.o: USE_IFs/BD_PCOMP0_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/NEXTC0_Interface.o obj/NEXTC20_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_PCOMP10_USE_IFs.o: USE_IFs/BD_PCOMP10_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/NEXTC0_Interface.o obj/NEXTC20_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_PCOMP1_USE_IFs.o: USE_IFs/BD_PCOMP1_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/I4FLD_Interface.o obj/CHAR_FLD_Interface.o obj/R8FLD_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CRDERR_Interface.o obj/NEXTC_Interface.o obj/NEXTC2_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_PCOMP_USE_IFs.o: USE_IFs/BD_PCOMP_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/I4FLD_Interface.o obj/R8FLD_Interface.o obj/CHAR_FLD_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CRDERR_Interface.o obj/NEXTC_Interface.o obj/NEXTC2_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_PELAS_USE_IFs.o: USE_IFs/BD_PELAS_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/I4FLD_Interface.o obj/R8FLD_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CARD_FLDS_NOT_BLANK_Interface.o obj/CRDERR_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_PLOAD2_USE_IFs.o: USE_IFs/BD_PLOAD2_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/I4FLD_Interface.o obj/R8FLD_Interface.o obj/TOKCHK_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CARD_FLDS_NOT_BLANK_Interface.o obj/CRDERR_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_PLOAD4_USE_IFs.o: USE_IFs/BD_PLOAD4_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/I4FLD_Interface.o obj/R8FLD_Interface.o obj/LEFT_ADJ_BDFLD_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CARD_FLDS_NOT_BLANK_Interface.o obj/CRDERR_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_PLOTEL_USE_IFs.o: USE_IFs/BD_PLOTEL_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/I4FLD_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CARD_FLDS_NOT_BLANK_Interface.o obj/CRDERR_Interface.o obj/ELEPRO_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_PMASS_USE_IFs.o: USE_IFs/BD_PMASS_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/I4FLD_Interface.o obj/R8FLD_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CRDERR_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_PROD_USE_IFs.o: USE_IFs/BD_PROD_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/I4FLD_Interface.o obj/R8FLD_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CARD_FLDS_NOT_BLANK_Interface.o obj/CRDERR_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_PSHEAR_USE_IFs.o: USE_IFs/BD_PSHEAR_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/I4FLD_Interface.o obj/R8FLD_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CARD_FLDS_NOT_BLANK_Interface.o obj/CRDERR_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_PSHEL_USE_IFs.o: USE_IFs/BD_PSHEL_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/I4FLD_Interface.o obj/R8FLD_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CRDERR_Interface.o obj/NEXTC_Interface.o obj/NEXTC2_Interface.o obj/CARD_FLDS_NOT_BLANK_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_PSOLID_USE_IFs.o: USE_IFs/BD_PSOLID_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/I4FLD_Interface.o obj/LEFT_ADJ_BDFLD_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CARD_FLDS_NOT_BLANK_Interface.o obj/CRDERR_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_PUSER1_USE_IFs.o: USE_IFs/BD_PUSER1_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/I4FLD_Interface.o obj/R8FLD_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CRDERR_Interface.o obj/NEXTC_Interface.o obj/NEXTC2_Interface.o obj/CARD_FLDS_NOT_BLANK_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_PUSERIN_USE_IFs.o: USE_IFs/BD_PUSERIN_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/I4FLD_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CARD_FLDS_NOT_BLANK_Interface.o obj/CRDERR_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_RBAR_USE_IFs.o: USE_IFs/BD_RBAR_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/I4FLD_Interface.o obj/IP6CHK_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CARD_FLDS_NOT_BLANK_Interface.o obj/CRDERR_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_RBE1_USE_IFs.o: USE_IFs/BD_RBE1_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/I4FLD_Interface.o obj/IP6CHK_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CARD_FLDS_NOT_BLANK_Interface.o obj/CRDERR_Interface.o obj/NEXTC_Interface.o obj/NEXTC2_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_RBE2_USE_IFs.o: USE_IFs/BD_RBE2_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/I4FLD_Interface.o obj/IP6CHK_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CRDERR_Interface.o obj/NEXTC_Interface.o obj/NEXTC2_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_RBE30_USE_IFs.o: USE_IFs/BD_RBE30_USE_IFs.f90 obj/OURTIM_Interface.o obj/NEXTC0_Interface.o obj/NEXTC20_Interface.o obj/MKJCARD_Interface.o obj/TOKCHK_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_RBE3_USE_IFs.o: USE_IFs/BD_RBE3_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/I4FLD_Interface.o obj/IP6CHK_Interface.o obj/R8FLD_Interface.o obj/ARRAY_SIZE_ERROR_1_Interface.o obj/TOKCHK_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CARD_FLDS_NOT_BLANK_Interface.o obj/CRDERR_Interface.o obj/NEXTC_Interface.o obj/NEXTC2_Interface.o obj/CHAR_FLD_Interface.o obj/RDOF_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_RFORCE_USE_IFs.o: USE_IFs/BD_RFORCE_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/I4FLD_Interface.o obj/R8FLD_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CARD_FLDS_NOT_BLANK_Interface.o obj/CRDERR_Interface.o obj/NEXTC_Interface.o obj/NEXTC2_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_RSPLINE0_USE_IFs.o: USE_IFs/BD_RSPLINE0_USE_IFs.f90 obj/OURTIM_Interface.o obj/NEXTC0_Interface.o obj/NEXTC20_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_RSPLINE_USE_IFs.o: USE_IFs/BD_RSPLINE_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/I4FLD_Interface.o obj/R8FLD_Interface.o obj/ARRAY_SIZE_ERROR_1_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CRDERR_Interface.o obj/NEXTC_Interface.o obj/NEXTC2_Interface.o obj/IP6CHK_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_SEQGP_USE_IFs.o: USE_IFs/BD_SEQGP_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/I4FLD_Interface.o obj/R8FLD_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CRDERR_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_SLOAD0_USE_IFs.o: USE_IFs/BD_SLOAD0_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_SLOAD_USE_IFs.o: USE_IFs/BD_SLOAD_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/I4FLD_Interface.o obj/R8FLD_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CARD_FLDS_NOT_BLANK_Interface.o obj/CRDERR_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_SPC1_USE_IFs.o: USE_IFs/BD_SPC1_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/I4FLD_Interface.o obj/IP6CHK_Interface.o obj/TOKCHK_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CARD_FLDS_NOT_BLANK_Interface.o obj/CRDERR_Interface.o obj/NEXTC_Interface.o obj/NEXTC2_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_SPCADD0_USE_IFs.o: USE_IFs/BD_SPCADD0_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/NEXTC0_Interface.o obj/NEXTC20_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_SPCADD_USE_IFs.o: USE_IFs/BD_SPCADD_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/I4FLD_Interface.o obj/OUTA_HERE_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CRDERR_Interface.o obj/NEXTC_Interface.o obj/NEXTC2_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_SPC_USE_IFs.o: USE_IFs/BD_SPC_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/I4FLD_Interface.o obj/IP6CHK_Interface.o obj/R8FLD_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CARD_FLDS_NOT_BLANK_Interface.o obj/CRDERR_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_SPOINT0_USE_IFs.o: USE_IFs/BD_SPOINT0_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/TOKCHK_Interface.o obj/I4FLD_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_SPOINT_USE_IFs.o: USE_IFs/BD_SPOINT_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/TOKCHK_Interface.o obj/I4FLD_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CARD_FLDS_NOT_BLANK_Interface.o obj/CRDERR_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_SUPORT_USE_IFs.o: USE_IFs/BD_SUPORT_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/I4FLD_Interface.o obj/IP6CHK_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CRDERR_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_TEMPD_USE_IFs.o: USE_IFs/BD_TEMPD_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/I4FLD_Interface.o obj/R8FLD_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CRDERR_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_TEMPRP_USE_IFs.o: USE_IFs/BD_TEMPRP_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/I4FLD_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CARD_FLDS_NOT_BLANK_Interface.o obj/R8FLD_Interface.o obj/CRDERR_Interface.o obj/NEXTC_Interface.o obj/NEXTC2_Interface.o obj/TOKCHK_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_TEMP_USE_IFs.o: USE_IFs/BD_TEMP_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/I4FLD_Interface.o obj/R8FLD_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CARD_FLDS_NOT_BLANK_Interface.o obj/CRDERR_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_USET1_USE_IFs.o: USE_IFs/BD_USET1_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/CHAR_FLD_Interface.o obj/LEFT_ADJ_BDFLD_Interface.o obj/IP6CHK_Interface.o obj/I4FLD_Interface.o obj/TOKCHK_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CARD_FLDS_NOT_BLANK_Interface.o obj/CRDERR_Interface.o obj/NEXTC_Interface.o obj/NEXTC2_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BD_USET_USE_IFs.o: USE_IFs/BD_USET_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/CHAR_FLD_Interface.o obj/LEFT_ADJ_BDFLD_Interface.o obj/I4FLD_Interface.o obj/IP6CHK_Interface.o obj/BD_IMBEDDED_BLANK_Interface.o obj/CARD_FLDS_NOT_BLANK_Interface.o obj/CRDERR_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BEAM_USE_IFs.o: USE_IFs/BEAM_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BMQMEM_USE_IFs.o: USE_IFs/BMQMEM_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BREL1_USE_IFs.o: USE_IFs/BREL1_USE_IFs.f90 obj/OURTIM_Interface.o obj/ROD1_Interface.o obj/BAR1_Interface.o obj/BEAM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BSMIN3_USE_IFs.o: USE_IFs/BSMIN3_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BSMIN4_USE_IFs.o: USE_IFs/BSMIN4_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BUILD_A_LR_USE_IFs.o: USE_IFs/BUILD_A_LR_USE_IFs.f90 obj/OURTIM_Interface.o obj/TDOF_COL_NUM_Interface.o obj/MERGE_COL_VECS_Interface.o obj/WRITE_VECTOR_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BUILD_F_AO_USE_IFs.o: USE_IFs/BUILD_F_AO_USE_IFs.f90 obj/OURTIM_Interface.o obj/MATMULT_SFF_Interface.o obj/TDOF_COL_NUM_Interface.o obj/MERGE_COL_VECS_Interface.o obj/WRITE_VECTOR_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BUILD_G_NM_USE_IFs.o: USE_IFs/BUILD_G_NM_USE_IFs.f90 obj/OURTIM_Interface.o obj/MATMULT_SFF_Interface.o obj/TDOF_COL_NUM_Interface.o obj/MERGE_COL_VECS_Interface.o obj/WRITE_VECTOR_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BUILD_N_FS_USE_IFs.o: USE_IFs/BUILD_N_FS_USE_IFs.f90 obj/OURTIM_Interface.o obj/TDOF_COL_NUM_Interface.o obj/MERGE_COL_VECS_Interface.o obj/WRITE_VECTOR_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BUSH_USE_IFs.o: USE_IFs/BUSH_USE_IFs.f90 obj/OURTIM_Interface.o obj/MATMULT_FFF_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CALC_CB_MEFM_MPF_USE_IFs.o: USE_IFs/CALC_CB_MEFM_MPF_USE_IFs.f90 obj/OURTIM_Interface.o obj/ALLOCATE_EIGEN1_MAT_Interface.o obj/SPARSE_CRS_TO_FULL_Interface.o obj/MATMULT_FFF_Interface.o obj/MATMULT_FFF_T_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CALC_ELEM_NODE_FORCES_USE_IFs.o: USE_IFs/CALC_ELEM_NODE_FORCES_USE_IFs.f90 obj/OURTIM_Interface.o obj/GET_GRID_NUM_COMPS_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CALC_ELEM_STRAINS_USE_IFs.o: USE_IFs/CALC_ELEM_STRAINS_USE_IFs.f90 obj/OURTIM_Interface.o obj/ONE_D_STRAIN_OUTPUTS_Interface.o obj/SHELL_STRAIN_OUTPUTS_Interface.o obj/SOLID_STRAIN_OUTPUTS_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CALC_ELEM_STRESSES_USE_IFs.o: USE_IFs/CALC_ELEM_STRESSES_USE_IFs.f90 obj/OURTIM_Interface.o obj/ONE_D_STRESS_OUTPUTS_Interface.o obj/SHELL_STRESS_OUTPUTS_Interface.o obj/SOLID_STRESS_OUTPUTS_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CALC_GEN_MASS_USE_IFs.o: USE_IFs/CALC_GEN_MASS_USE_IFs.f90 obj/OURTIM_Interface.o obj/MATMULT_SFF_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CALC_KRRcb_USE_IFs.o: USE_IFs/CALC_KRRcb_USE_IFs.f90 obj/OURTIM_Interface.o obj/ALLOCATE_SCR_CCS_MAT_Interface.o obj/SPARSE_CRS_SPARSE_CCS_Interface.o obj/MATMULT_SSS_NTERM_Interface.o obj/ALLOCATE_SCR_CRS_MAT_Interface.o obj/MATMULT_SSS_Interface.o obj/DEALLOCATE_SCR_MAT_Interface.o obj/SPARSE_CRS_TERM_COUNT_Interface.o obj/CRS_NONSYM_TO_CRS_SYM_Interface.o obj/OUTA_HERE_Interface.o obj/MATADD_SSS_NTERM_Interface.o obj/ALLOCATE_SPARSE_MAT_Interface.o obj/MATADD_SSS_Interface.o obj/DEALLOCATE_LAPACK_MAT_Interface.o obj/SYM_MAT_DECOMP_LAPACK_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CALC_MRN_USE_IFs.o: USE_IFs/CALC_MRN_USE_IFs.f90 obj/OURTIM_Interface.o obj/ALLOCATE_SPARSE_MAT_Interface.o obj/SPARSE_MAT_DIAG_ZEROS_Interface.o obj/CRS_SYM_TO_CRS_NONSYM_Interface.o obj/ALLOCATE_SCR_CCS_MAT_Interface.o obj/SPARSE_CRS_SPARSE_CCS_Interface.o obj/MATMULT_SSS_NTERM_Interface.o obj/ALLOCATE_SCR_CRS_MAT_Interface.o obj/MATMULT_SSS_Interface.o obj/OUTA_HERE_Interface.o obj/DEALLOCATE_SCR_MAT_Interface.o obj/MATADD_SSS_NTERM_Interface.o obj/MATADD_SSS_Interface.o obj/MATMULT_SFS_NTERM_Interface.o obj/DEALLOCATE_SPARSE_MAT_Interface.o obj/MATMULT_SFS_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CALC_MRRcb_USE_IFs.o: USE_IFs/CALC_MRRcb_USE_IFs.f90 obj/OURTIM_Interface.o obj/ALLOCATE_SPARSE_MAT_Interface.o obj/ALLOCATE_SCR_CCS_MAT_Interface.o obj/SPARSE_CRS_SPARSE_CCS_Interface.o obj/MATMULT_SSS_NTERM_Interface.o obj/ALLOCATE_SCR_CRS_MAT_Interface.o obj/MATMULT_SSS_Interface.o obj/MATTRNSP_SS_Interface.o obj/MATADD_SSS_NTERM_Interface.o obj/MATADD_SSS_Interface.o obj/DEALLOCATE_SCR_MAT_Interface.o obj/SPARSE_CRS_TERM_COUNT_Interface.o obj/CRS_NONSYM_TO_CRS_SYM_Interface.o obj/OUTA_HERE_Interface.o obj/DEALLOCATE_SPARSE_MAT_Interface.o obj/SPARSE_CRS_TO_FULL_Interface.o obj/MATMULT_FFF_Interface.o obj/MATMULT_FFF_T_Interface.o obj/SPARSE_MAT_DIAG_ZEROS_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CALC_PHIZL_USE_IFs.o: USE_IFs/CALC_PHIZL_USE_IFs.f90 obj/OURTIM_Interface.o obj/ALLOCATE_SPARSE_MAT_Interface.o obj/MATTRNSP_SS_Interface.o obj/ALLOCATE_SCR_CCS_MAT_Interface.o obj/SPARSE_CRS_SPARSE_CCS_Interface.o obj/MATMULT_SSS_NTERM_Interface.o obj/ALLOCATE_SCR_CRS_MAT_Interface.o obj/MATMULT_SSS_Interface.o obj/DEALLOCATE_SCR_MAT_Interface.o obj/MATADD_SSS_NTERM_Interface.o obj/MATADD_SSS_Interface.o obj/SOLVE_PHIZL1_Interface.o obj/CNT_NONZ_IN_FULL_MAT_Interface.o obj/FULL_TO_SPARSE_CRS_Interface.o obj/MERGE_MAT_COLS_SSS_Interface.o obj/WRITE_SPARSE_CRS_Interface.o obj/DEALLOCATE_SPARSE_MAT_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CALC_PHI_SQ_USE_IFs.o: USE_IFs/CALC_PHI_SQ_USE_IFs.f90 obj/OURTIM_Interface.o obj/GET_PCOMP_SECT_PROPS_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CALC_TDOF_ROW_START_USE_IFs.o: USE_IFs/CALC_TDOF_ROW_START_USE_IFs.f90 obj/OURTIM_Interface.o obj/GET_GRID_NUM_COMPS_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CALC_VEC_SORT_ORDER_USE_IFs.o: USE_IFs/CALC_VEC_SORT_ORDER_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CARD_FLDS_NOT_BLANK_USE_IFs.o: USE_IFs/CARD_FLDS_NOT_BLANK_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_ACCE_USE_IFs.o: USE_IFs/CC_ACCE_USE_IFs.f90 obj/OURTIM_Interface.o obj/CC_OUTPUTS_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_DISP_USE_IFs.o: USE_IFs/CC_DISP_USE_IFs.f90 obj/OURTIM_Interface.o obj/CC_OUTPUTS_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_ECHO_USE_IFs.o: USE_IFs/CC_ECHO_USE_IFs.f90 obj/OURTIM_Interface.o obj/CSHIFT_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_ELDA_USE_IFs.o: USE_IFs/CC_ELDA_USE_IFs.f90 obj/OURTIM_Interface.o obj/GET_ANSID_Interface.o obj/STOKEN_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_ELFO_USE_IFs.o: USE_IFs/CC_ELFO_USE_IFs.f90 obj/OURTIM_Interface.o obj/CC_OUTPUTS_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_ENFO_USE_IFs.o: USE_IFs/CC_ENFO_USE_IFs.f90 obj/OURTIM_Interface.o obj/CSHIFT_Interface.o obj/GET_CHAR_STRING_END_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_GPFO_USE_IFs.o: USE_IFs/CC_GPFO_USE_IFs.f90 obj/OURTIM_Interface.o obj/CC_OUTPUTS_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_LABE_USE_IFs.o: USE_IFs/CC_LABE_USE_IFs.f90 obj/OURTIM_Interface.o obj/CSHIFT_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_LOAD_USE_IFs.o: USE_IFs/CC_LOAD_USE_IFs.f90 obj/OURTIM_Interface.o obj/GET_SETID_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_METH_USE_IFs.o: USE_IFs/CC_METH_USE_IFs.f90 obj/OURTIM_Interface.o obj/GET_SETID_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_MPCF_USE_IFs.o: USE_IFs/CC_MPCF_USE_IFs.f90 obj/OURTIM_Interface.o obj/CC_OUTPUTS_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_MPC_USE_IFs.o: USE_IFs/CC_MPC_USE_IFs.f90 obj/OURTIM_Interface.o obj/GET_SETID_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_NLPARM_USE_IFs.o: USE_IFs/CC_NLPARM_USE_IFs.f90 obj/OURTIM_Interface.o obj/GET_SETID_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_OLOA_USE_IFs.o: USE_IFs/CC_OLOA_USE_IFs.f90 obj/OURTIM_Interface.o obj/CC_OUTPUTS_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_OUTPUTS_USE_IFs.o: USE_IFs/CC_OUTPUTS_USE_IFs.f90 obj/OURTIM_Interface.o obj/GET_ANSID_Interface.o obj/PARSE_CHAR_STRING_Interface.o obj/CHK_CC_CMD_DESCRIBERS_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_SET0_USE_IFs.o: USE_IFs/CC_SET0_USE_IFs.f90 obj/OURTIM_Interface.o obj/TOKCHK_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_SET_USE_IFs.o: USE_IFs/CC_SET_USE_IFs.f90 obj/OURTIM_Interface.o obj/TOKCHK_Interface.o obj/OUTA_HERE_Interface.o obj/STOKEN_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_SPCF_USE_IFs.o: USE_IFs/CC_SPCF_USE_IFs.f90 obj/OURTIM_Interface.o obj/CC_OUTPUTS_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_SPC_USE_IFs.o: USE_IFs/CC_SPC_USE_IFs.f90 obj/OURTIM_Interface.o obj/GET_SETID_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_STRE_USE_IFs.o: USE_IFs/CC_STRE_USE_IFs.f90 obj/OURTIM_Interface.o obj/CC_OUTPUTS_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_STRN_USE_IFs.o: USE_IFs/CC_STRN_USE_IFs.f90 obj/OURTIM_Interface.o obj/CC_OUTPUTS_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_SUBC_USE_IFs.o: USE_IFs/CC_SUBC_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o obj/CSHIFT_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_SUBT_USE_IFs.o: USE_IFs/CC_SUBT_USE_IFs.f90 obj/OURTIM_Interface.o obj/CSHIFT_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_TEMP_USE_IFs.o: USE_IFs/CC_TEMP_USE_IFs.f90 obj/OURTIM_Interface.o obj/GET_SETID_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CC_TITL_USE_IFs.o: USE_IFs/CC_TITL_USE_IFs.f90 obj/OURTIM_Interface.o obj/CSHIFT_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CHAR_FLD_USE_IFs.o: USE_IFs/CHAR_FLD_USE_IFs.f90
	$(F77) $(FLAGS) -c $< -o $@
obj/CHECK_BAR_MOIs_USE_IFs.o: USE_IFs/CHECK_BAR_MOIs_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CHECK_MAT_INVERSE_USE_IFs.o: USE_IFs/CHECK_MAT_INVERSE_USE_IFs.f90 obj/MATMULT_FFF_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CHECK_TE_MATRIX_USE_IFs.o: USE_IFs/CHECK_TE_MATRIX_USE_IFs.f90 obj/MATMULT_FFF_T_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CHK_ARRAY_ALLOC_STAT_USE_IFs.o: USE_IFs/CHK_ARRAY_ALLOC_STAT_USE_IFs.f90
	$(F77) $(FLAGS) -c $< -o $@
obj/CHK_CC_CMD_DESCRIBERS_USE_IFs.o: USE_IFs/CHK_CC_CMD_DESCRIBERS_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CLOSE_LIJFILES_USE_IFs.o: USE_IFs/CLOSE_LIJFILES_USE_IFs.f90 obj/FILE_CLOSE_Interface.o obj/OPNERR_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CLOSE_OUTFILES_USE_IFs.o: USE_IFs/CLOSE_OUTFILES_USE_IFs.f90 obj/FILE_CLOSE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CNT_NONZ_IN_FULL_MAT_USE_IFs.o: USE_IFs/CNT_NONZ_IN_FULL_MAT_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/COND_NUM_USE_IFs.o: USE_IFs/COND_NUM_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CONM2_PROC_1_USE_IFs.o: USE_IFs/CONM2_PROC_1_USE_IFs.f90 obj/OURTIM_Interface.o obj/GET_ARRAY_ROW_NUM_Interface.o obj/GET_GRID_NUM_COMPS_Interface.o obj/OUTA_HERE_Interface.o obj/GEN_T0L_Interface.o obj/MATMULT_FFF_Interface.o obj/MATMULT_FFF_T_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CONM2_PROC_2_USE_IFs.o: USE_IFs/CONM2_PROC_2_USE_IFs.f90 obj/OURTIM_Interface.o obj/GET_ARRAY_ROW_NUM_Interface.o obj/GEN_T0L_Interface.o obj/MATMULT_FFF_T_Interface.o obj/MATMULT_FFF_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CONVERT_INT_TO_CHAR_USE_IFs.o: USE_IFs/CONVERT_INT_TO_CHAR_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CONVERT_VEC_COORD_SYS_USE_IFs.o: USE_IFs/CONVERT_VEC_COORD_SYS_USE_IFs.f90 obj/OURTIM_Interface.o obj/GET_GRID_NUM_COMPS_Interface.o obj/GET_ARRAY_ROW_NUM_Interface.o obj/GEN_T0L_Interface.o obj/MATMULT_FFF_Interface.o obj/OUTA_HERE_Interface.o obj/MATMULT_FFF_T_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CORD_PROC_USE_IFs.o: USE_IFs/CORD_PROC_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o obj/CROSS_Interface.o obj/MATMULT_FFF_Interface.o obj/SORT_INT1_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CRDERR_USE_IFs.o: USE_IFs/CRDERR_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CROSS_USE_IFs.o: USE_IFs/CROSS_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CRS_NONSYM_TO_CRS_SYM_USE_IFs.o: USE_IFs/CRS_NONSYM_TO_CRS_SYM_USE_IFs.f90 obj/OURTIM_Interface.o obj/ARRAY_SIZE_ERROR_1_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CRS_SYM_TO_CRS_NONSYM_USE_IFs.o: USE_IFs/CRS_SYM_TO_CRS_NONSYM_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CSHIFT_USE_IFs.o: USE_IFs/CSHIFT_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DATA_SET_NAME_ERROR_USE_IFs.o: USE_IFs/DATA_SET_NAME_ERROR_USE_IFs.f90 obj/WRITE_FILNAM_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DATA_SET_SIZE_ERROR_USE_IFs.o: USE_IFs/DATA_SET_SIZE_ERROR_USE_IFs.f90 obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEALLOCATE_CB_ELM_OTM_USE_IFs.o: USE_IFs/DEALLOCATE_CB_ELM_OTM_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o obj/ALLOCATED_MEMORY_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEALLOCATE_CB_GRD_OTM_USE_IFs.o: USE_IFs/DEALLOCATE_CB_GRD_OTM_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o obj/ALLOCATED_MEMORY_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEALLOCATE_COL_VEC_USE_IFs.o: USE_IFs/DEALLOCATE_COL_VEC_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o obj/ALLOCATED_MEMORY_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEALLOCATE_DOF_TABLES_USE_IFs.o: USE_IFs/DEALLOCATE_DOF_TABLES_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o obj/ALLOCATED_MEMORY_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEALLOCATE_EIGEN1_MAT_USE_IFs.o: USE_IFs/DEALLOCATE_EIGEN1_MAT_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o obj/ALLOCATED_MEMORY_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEALLOCATE_EMS_ARRAYS_USE_IFs.o: USE_IFs/DEALLOCATE_EMS_ARRAYS_USE_IFs.f90 obj/OURTIM_Interface.o obj/ALLOCATED_MEMORY_Interface.o obj/WRITE_MEM_SUM_TO_F04_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEALLOCATE_FEMAP_DATA_USE_IFs.o: USE_IFs/DEALLOCATE_FEMAP_DATA_USE_IFs.f90 obj/OURTIM_Interface.o obj/ALLOCATED_MEMORY_Interface.o obj/WRITE_MEM_SUM_TO_F04_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEALLOCATE_FULL_MAT_USE_IFs.o: USE_IFs/DEALLOCATE_FULL_MAT_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o obj/ALLOCATED_MEMORY_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEALLOCATE_IN4_FILES_USE_IFs.o: USE_IFs/DEALLOCATE_IN4_FILES_USE_IFs.f90 obj/OURTIM_Interface.o obj/ALLOCATED_MEMORY_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEALLOCATE_L1_MGG_USE_IFs.o: USE_IFs/DEALLOCATE_L1_MGG_USE_IFs.f90 obj/OURTIM_Interface.o obj/ALLOCATED_MEMORY_Interface.o obj/WRITE_MEM_SUM_TO_F04_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEALLOCATE_L2_GMN_2_USE_IFs.o: USE_IFs/DEALLOCATE_L2_GMN_2_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o obj/ALLOCATED_MEMORY_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEALLOCATE_L2_GOA_2_USE_IFs.o: USE_IFs/DEALLOCATE_L2_GOA_2_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o obj/ALLOCATED_MEMORY_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEALLOCATE_L6_2_USE_IFs.o: USE_IFs/DEALLOCATE_L6_2_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o obj/ALLOCATED_MEMORY_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEALLOCATE_LAPACK_MAT_USE_IFs.o: USE_IFs/DEALLOCATE_LAPACK_MAT_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o obj/ALLOCATED_MEMORY_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEALLOCATE_LINK9_STUF_USE_IFs.o: USE_IFs/DEALLOCATE_LINK9_STUF_USE_IFs.f90 obj/OURTIM_Interface.o obj/ALLOCATED_MEMORY_Interface.o obj/WRITE_MEM_SUM_TO_F04_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEALLOCATE_MISC_MAT_USE_IFs.o: USE_IFs/DEALLOCATE_MISC_MAT_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o obj/ALLOCATED_MEMORY_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEALLOCATE_MODEL_STUF_USE_IFs.o: USE_IFs/DEALLOCATE_MODEL_STUF_USE_IFs.f90 obj/OURTIM_Interface.o obj/ALLOCATED_MEMORY_Interface.o obj/WRITE_MEM_SUM_TO_F04_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEALLOCATE_NL_PARAMS_USE_IFs.o: USE_IFs/DEALLOCATE_NL_PARAMS_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o obj/ALLOCATED_MEMORY_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEALLOCATE_RBGLOBAL_USE_IFs.o: USE_IFs/DEALLOCATE_RBGLOBAL_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o obj/ALLOCATED_MEMORY_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEALLOCATE_SCR_MAT_USE_IFs.o: USE_IFs/DEALLOCATE_SCR_MAT_USE_IFs.f90 obj/OURTIM_Interface.o obj/ALLOCATED_MEMORY_Interface.o obj/WRITE_MEM_SUM_TO_F04_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEALLOCATE_SPARSE_ALG_USE_IFs.o: USE_IFs/DEALLOCATE_SPARSE_ALG_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o obj/ALLOCATED_MEMORY_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEALLOCATE_SPARSE_MAT_USE_IFs.o: USE_IFs/DEALLOCATE_SPARSE_MAT_USE_IFs.f90 obj/OURTIM_Interface.o obj/ALLOCATED_MEMORY_Interface.o obj/WRITE_MEM_SUM_TO_F04_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEALLOCATE_STF_ARRAYS_USE_IFs.o: USE_IFs/DEALLOCATE_STF_ARRAYS_USE_IFs.f90 obj/OURTIM_Interface.o obj/ALLOCATED_MEMORY_Interface.o obj/WRITE_MEM_SUM_TO_F04_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEALLOCATE_TEMPLATE_USE_IFs.o: USE_IFs/DEALLOCATE_TEMPLATE_USE_IFs.f90 obj/OURTIM_Interface.o obj/ALLOCATED_MEMORY_Interface.o obj/WRITE_MEM_SUM_TO_F04_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DOF_PROC_USE_IFs.o: USE_IFs/DOF_PROC_USE_IFs.f90 obj/OURTIM_Interface.o obj/TSET_PROC_Interface.o obj/USET_PROC_Interface.o obj/TDOF_PROC_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/EC_DEBUG_USE_IFs.o: USE_IFs/EC_DEBUG_USE_IFs.f90 obj/MKJCARD_08_Interface.o obj/I4FLD_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/EC_IN4FIL_USE_IFs.o: USE_IFs/EC_IN4FIL_USE_IFs.f90 obj/OURTIM_Interface.o obj/TOKCHK_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/EC_OUTPUT4_USE_IFs.o: USE_IFs/EC_OUTPUT4_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/EC_PARTN_USE_IFs.o: USE_IFs/EC_PARTN_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/EIG_GIV_MGIV_USE_IFs.o: USE_IFs/EIG_GIV_MGIV_USE_IFs.f90 obj/OURTIM_Interface.o obj/BANDSIZ_Interface.o obj/ALLOCATE_LAPACK_MAT_Interface.o obj/BANDGEN_LAPACK_DPB_Interface.o obj/WRITE_MATRIX_BY_ROWS_Interface.o obj/DEALLOCATE_SPARSE_MAT_Interface.o obj/ALLOCATE_EIGEN1_MAT_Interface.o obj/INVERT_EIGENS_Interface.o obj/OUTA_HERE_Interface.o obj/GET_GRID_AND_COMP_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/EIG_INV_PWR_USE_IFs.o: USE_IFs/EIG_INV_PWR_USE_IFs.f90 obj/OURTIM_Interface.o obj/MATADD_SSS_NTERM_Interface.o obj/ALLOCATE_SPARSE_MAT_Interface.o obj/MATADD_SSS_Interface.o obj/DEALLOCATE_SPARSE_MAT_Interface.o obj/ALLOCATE_EIGEN1_MAT_Interface.o obj/SYM_MAT_DECOMP_LAPACK_Interface.o obj/OUTA_HERE_Interface.o obj/MATMULT_SFF_Interface.o obj/FBS_LAPACK_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/EIG_LANCZOS_ARPACK_USE_IFs.o: USE_IFs/EIG_LANCZOS_ARPACK_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o obj/MATADD_SSS_NTERM_Interface.o obj/ALLOCATE_SPARSE_MAT_Interface.o obj/MATADD_SSS_Interface.o obj/BANDSIZ_Interface.o obj/ALLOCATE_LAPACK_MAT_Interface.o obj/BANDGEN_LAPACK_DPB_Interface.o obj/BANDGEN_LAPACK_DGB_Interface.o obj/WRITE_MATRIX_BY_ROWS_Interface.o obj/DEALLOCATE_SPARSE_MAT_Interface.o obj/SPARSE_MAT_DIAG_ZEROS_Interface.o obj/CRS_SYM_TO_CRS_NONSYM_Interface.o obj/WRITE_SPARSE_CRS_Interface.o obj/ALLOCATE_EIGEN1_MAT_Interface.o obj/DEALLOCATE_LAPACK_MAT_Interface.o obj/GET_GRID_AND_COMP_Interface.o obj/INVERT_EIGENS_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/EIG_SUMMARY_USE_IFs.o: USE_IFs/EIG_SUMMARY_USE_IFs.f90 obj/OURTIM_Interface.o obj/FILE_OPEN_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ELAS1_USE_IFs.o: USE_IFs/ELAS1_USE_IFs.f90 obj/OURTIM_Interface.o obj/GET_GRID_NUM_COMPS_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ELEM_PROP_MATL_IIDS_USE_IFs.o: USE_IFs/ELEM_PROP_MATL_IIDS_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ELEM_STRE_STRN_ARRAYS_USE_IFs.o: USE_IFs/ELEM_STRE_STRN_ARRAYS_USE_IFs.f90 obj/OURTIM_Interface.o obj/MATMULT_FFF_Interface.o obj/MATADD_FFF_Interface.o obj/STR_TENSOR_TRANSFORM_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ELEM_TRANSFORM_LBG_USE_IFs.o: USE_IFs/ELEM_TRANSFORM_LBG_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o obj/ELMTLB_Interface.o obj/GET_ARRAY_ROW_NUM_Interface.o obj/GEN_T0L_Interface.o obj/MATGET_Interface.o obj/MATMULT_FFF_Interface.o obj/MATMULT_FFF_T_Interface.o obj/MATPUT_Interface.o obj/ELMOFF_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ELEPRO_USE_IFs.o: USE_IFs/ELEPRO_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o obj/I4FLD_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ELESORT_USE_IFs.o: USE_IFs/ELESORT_USE_IFs.f90 obj/OURTIM_Interface.o obj/SORT_INT3_CHAR2_Interface.o obj/SORT_INT1_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ELMDAT1_USE_IFs.o: USE_IFs/ELMDAT1_USE_IFs.f90 obj/OURTIM_Interface.o obj/GET_ELGP_Interface.o obj/OUTA_HERE_Interface.o obj/GET_ELEM_AGRID_BGRID_Interface.o obj/GET_GRID_NUM_COMPS_Interface.o obj/GET_ARRAY_ROW_NUM_Interface.o obj/GEN_T0L_Interface.o obj/DEALLOCATE_MODEL_STUF_Interface.o obj/ALLOCATE_MODEL_STUF_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ELMDAT2_USE_IFs.o: USE_IFs/ELMDAT2_USE_IFs.f90 obj/OURTIM_Interface.o obj/GET_ELGP_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ELMDIS_PLY_USE_IFs.o: USE_IFs/ELMDIS_PLY_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ELMDIS_USE_IFs.o: USE_IFs/ELMDIS_USE_IFs.f90 obj/OURTIM_Interface.o obj/GET_ARRAY_ROW_NUM_Interface.o obj/GET_GRID_NUM_COMPS_Interface.o obj/TDOF_COL_NUM_Interface.o obj/GEN_T0L_Interface.o obj/MATGET_Interface.o obj/MATMULT_FFF_Interface.o obj/MATPUT_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ELMGM1_USE_IFs.o: USE_IFs/ELMGM1_USE_IFs.f90 obj/OURTIM_Interface.o obj/GEN_T0L_Interface.o obj/CALC_VEC_SORT_ORDER_Interface.o obj/CROSS_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ELMGM2_USE_IFs.o: USE_IFs/ELMGM2_USE_IFs.f90 obj/OURTIM_Interface.o obj/CROSS_Interface.o obj/PLANE_COORD_TRANS_21_Interface.o obj/MATMULT_FFF_Interface.o obj/CHECK_TE_MATRIX_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ELMGM3_USE_IFs.o: USE_IFs/ELMGM3_USE_IFs.f90 obj/OURTIM_Interface.o obj/CROSS_Interface.o obj/PLANE_COORD_TRANS_21_Interface.o obj/MATMULT_FFF_Interface.o obj/CHECK_TE_MATRIX_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ELMOFF_USE_IFs.o: USE_IFs/ELMOFF_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o obj/MATMULT_FFF_Interface.o obj/MATMULT_FFF_T_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ELMOUT_USE_IFs.o: USE_IFs/ELMOUT_USE_IFs.f90 obj/OURTIM_Interface.o obj/GET_GRID_NUM_COMPS_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ELMTLB_USE_IFs.o: USE_IFs/ELMTLB_USE_IFs.f90 obj/OURTIM_Interface.o obj/MATGET_Interface.o obj/MATMULT_FFF_Interface.o obj/MATMULT_FFF_T_Interface.o obj/MATPUT_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ELSAVE_USE_IFs.o: USE_IFs/ELSAVE_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/EMG_USE_IFs.o: USE_IFs/EMG_USE_IFs.f90 obj/IS_ELEM_PCOMP_PROPS_Interface.o obj/OURTIM_Interface.o obj/ELMDAT1_Interface.o obj/OUTA_HERE_Interface.o obj/ELMGM1_Interface.o obj/ELMGM2_Interface.o obj/ELMGM3_Interface.o obj/GET_MATANGLE_FROM_CID_Interface.o obj/MATERIAL_PROPS_2D_Interface.o obj/ROT_AXES_MATL_TO_LOC_Interface.o obj/MATERIAL_PROPS_3D_Interface.o obj/ELMOUT_Interface.o obj/SHELL_ABD_MATRICES_Interface.o obj/ELMDAT2_Interface.o obj/ELAS1_Interface.o obj/BREL1_Interface.o obj/BUSH_Interface.o obj/TREL1_Interface.o obj/QDEL1_Interface.o obj/HEXA_Interface.o obj/PENTA_Interface.o obj/TETRA_Interface.o obj/KUSER1_Interface.o obj/USERIN_Interface.o obj/ELMOFF_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/EMP0_USE_IFs.o: USE_IFs/EMP0_USE_IFs.f90 obj/OURTIM_Interface.o obj/GET_ELGP_Interface.o obj/EMG_Interface.o obj/ELEM_TRANSFORM_LBG_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/EMP_USE_IFs.o: USE_IFs/EMP_USE_IFs.f90 obj/OURTIM_Interface.o obj/EMG_Interface.o obj/WRITE_EOFIL_Interface.o obj/GET_ARRAY_ROW_NUM_Interface.o obj/GET_GRID_NUM_COMPS_Interface.o obj/TDOF_COL_NUM_Interface.o obj/ELEM_TRANSFORM_LBG_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/EPSCALC_USE_IFs.o: USE_IFs/EPSCALC_USE_IFs.f90 obj/OURTIM_Interface.o obj/MATMULT_SFF_Interface.o obj/MATADD_FFF_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/EPTL_USE_IFs.o: USE_IFs/EPTL_USE_IFs.f90 obj/OURTIM_Interface.o obj/EMG_Interface.o obj/WRITE_EOFIL_Interface.o obj/GET_ARRAY_ROW_NUM_Interface.o obj/GET_GRID_NUM_COMPS_Interface.o obj/TDOF_COL_NUM_Interface.o obj/ELEM_TRANSFORM_LBG_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ESP0_FINAL_USE_IFs.o: USE_IFs/ESP0_FINAL_USE_IFs.f90 obj/OURTIM_Interface.o obj/EMG_Interface.o obj/GET_ARRAY_ROW_NUM_Interface.o obj/GET_GRID_NUM_COMPS_Interface.o obj/TDOF_COL_NUM_Interface.o obj/ELEM_TRANSFORM_LBG_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ESP0_USE_IFs.o: USE_IFs/ESP0_USE_IFs.f90 obj/OURTIM_Interface.o obj/GET_ELGP_Interface.o obj/EMG_Interface.o obj/ELEM_TRANSFORM_LBG_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ESP_USE_IFs.o: USE_IFs/ESP_USE_IFs.f90 obj/OURTIM_Interface.o obj/ALLOCATE_TEMPLATE_Interface.o obj/EMG_Interface.o obj/WRITE_EOFIL_Interface.o obj/GET_ARRAY_ROW_NUM_Interface.o obj/GET_GRID_NUM_COMPS_Interface.o obj/TDOF_COL_NUM_Interface.o obj/ELEM_TRANSFORM_LBG_Interface.o obj/OUTA_HERE_Interface.o obj/DEALLOCATE_TEMPLATE_Interface.o obj/OPNERR_Interface.o obj/FILE_CLOSE_Interface.o obj/DEALLOCATE_STF_ARRAYS_Interface.o obj/ALLOCATE_STF_ARRAYS_Interface.o obj/READERR_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/EXPAND_PHIXA_TO_PHIXG_USE_IFs.o: USE_IFs/EXPAND_PHIXA_TO_PHIXG_USE_IFs.f90 obj/OURTIM_Interface.o obj/ALLOCATE_COL_VEC_Interface.o obj/GET_SPARSE_CRS_COL_Interface.o obj/BUILD_F_AO_Interface.o obj/DEALLOCATE_COL_VEC_Interface.o obj/BUILD_N_FS_Interface.o obj/BUILD_G_NM_Interface.o obj/CNT_NONZ_IN_FULL_MAT_Interface.o obj/ALLOCATE_SPARSE_MAT_Interface.o obj/FULL_TO_SPARSE_CRS_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/FBS_LAPACK_USE_IFs.o: USE_IFs/FBS_LAPACK_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/FFIELD2_USE_IFs.o: USE_IFs/FFIELD2_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKCARD_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/FFIELD_USE_IFs.o: USE_IFs/FFIELD_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/MKCARD_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/FILERR_USE_IFs.o: USE_IFs/FILERR_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/FILE_CLOSE_USE_IFs.o: USE_IFs/FILE_CLOSE_USE_IFs.f90 obj/OURTIM_Interface.o obj/WRITE_FILNAM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/FILE_INQUIRE_USE_IFs.o: USE_IFs/FILE_INQUIRE_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/FILE_OPEN_USE_IFs.o: USE_IFs/FILE_OPEN_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o obj/READERR_Interface.o obj/STMERR_Interface.o obj/OPNERR_Interface.o obj/FILERR_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/FORCE_MOM_PROC_USE_IFs.o: USE_IFs/FORCE_MOM_PROC_USE_IFs.f90 obj/OURTIM_Interface.o obj/OPNERR_Interface.o obj/FILE_CLOSE_Interface.o obj/OUTA_HERE_Interface.o obj/READERR_Interface.o obj/GET_ARRAY_ROW_NUM_Interface.o obj/GEN_T0L_Interface.o obj/MATMULT_FFF_Interface.o obj/MATMULT_FFF_T_Interface.o obj/TDOF_COL_NUM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/FULL_TO_SPARSE_CRS_USE_IFs.o: USE_IFs/FULL_TO_SPARSE_CRS_USE_IFs.f90 obj/OURTIM_Interface.o obj/ARRAY_SIZE_ERROR_1_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GEN_T0L_USE_IFs.o: USE_IFs/GEN_T0L_USE_IFs.f90 obj/OURTIM_Interface.o obj/MATMULT_FFF_T_Interface.o obj/MATMULT_FFF_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_ANSID_USE_IFs.o: USE_IFs/GET_ANSID_USE_IFs.f90 obj/OURTIM_Interface.o obj/CSHIFT_Interface.o obj/STOKEN_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_ARRAY_ROW_NUM_USE_IFs.o: USE_IFs/GET_ARRAY_ROW_NUM_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_CHAR_STRING_END_USE_IFs.o: USE_IFs/GET_CHAR_STRING_END_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_COMMAND_LINE_USE_IFs.o: USE_IFs/GET_COMMAND_LINE_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_COMP_SHELL_ALLOWS_USE_IFs.o: USE_IFs/GET_COMP_SHELL_ALLOWS_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_ELEM_AGRID_BGRID_USE_IFs.o: USE_IFs/GET_ELEM_AGRID_BGRID_USE_IFs.f90 obj/OURTIM_Interface.o obj/GET_ELGP_Interface.o obj/GET_ARRAY_ROW_NUM_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_ELEM_NUM_PLIES_USE_IFs.o: USE_IFs/GET_ELEM_NUM_PLIES_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_ELEM_ONAME_USE_IFs.o: USE_IFs/GET_ELEM_ONAME_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_ELGP_USE_IFs.o: USE_IFs/GET_ELGP_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_FORMATTED_INTEGER_USE_IFs.o: USE_IFs/GET_FORMATTED_INTEGER_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_GRID_6X6_MASS_USE_IFs.o: USE_IFs/GET_GRID_6X6_MASS_USE_IFs.f90 obj/OURTIM_Interface.o obj/GET_GRID_NUM_COMPS_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_GRID_AND_COMP_USE_IFs.o: USE_IFs/GET_GRID_AND_COMP_USE_IFs.f90 obj/OURTIM_Interface.o obj/TDOF_COL_NUM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_GRID_NUM_COMPS_USE_IFs.o: USE_IFs/GET_GRID_NUM_COMPS_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_I2_MAT_FROM_I_MAT_USE_IFs.o: USE_IFs/GET_I2_MAT_FROM_I_MAT_USE_IFs.f90 obj/OURTIM_Interface.o obj/ARRAY_SIZE_ERROR_1_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_INI_FILNAM_USE_IFs.o: USE_IFs/GET_INI_FILNAM_USE_IFs.f90
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_I_MAT_FROM_I2_MAT_USE_IFs.o: USE_IFs/GET_I_MAT_FROM_I2_MAT_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_MACHINE_PARAMS_USE_IFs.o: USE_IFs/GET_MACHINE_PARAMS_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_MATANGLE_FROM_CID_USE_IFs.o: USE_IFs/GET_MATANGLE_FROM_CID_USE_IFs.f90 obj/OURTIM_Interface.o obj/PROJ_VEC_ONTO_PLANE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_MATRIX_DIAG_STATS_USE_IFs.o: USE_IFs/GET_MATRIX_DIAG_STATS_USE_IFs.f90 obj/OURTIM_Interface.o obj/TDOF_COL_NUM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_MAX_MIN_ABS_STR_USE_IFs.o: USE_IFs/GET_MAX_MIN_ABS_STR_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_MYSTRAN_DIR_USE_IFs.o: USE_IFs/GET_MYSTRAN_DIR_USE_IFs.f90
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_OU4_MAT_STATS_USE_IFs.o: USE_IFs/GET_OU4_MAT_STATS_USE_IFs.f90 obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_PCOMP_SECT_PROPS_USE_IFs.o: USE_IFs/GET_PCOMP_SECT_PROPS_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_SETID_USE_IFs.o: USE_IFs/GET_SETID_USE_IFs.f90 obj/OURTIM_Interface.o obj/CSHIFT_Interface.o obj/STOKEN_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_SPARSE_CRS_COL_USE_IFs.o: USE_IFs/GET_SPARSE_CRS_COL_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_SPARSE_CRS_ROW_USE_IFs.o: USE_IFs/GET_SPARSE_CRS_ROW_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_SPARSE_MAT_TERM_USE_IFs.o: USE_IFs/GET_SPARSE_MAT_TERM_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o obj/ARRAY_SIZE_ERROR_1_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_UG_123_IN_GRD_ORD_USE_IFs.o: USE_IFs/GET_UG_123_IN_GRD_ORD_USE_IFs.f90 obj/OURTIM_Interface.o obj/GET_GRID_NUM_COMPS_Interface.o obj/ARRAY_SIZE_ERROR_1_Interface.o obj/OUTA_HERE_Interface.o obj/SORT_INT1_REAL3_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_VEC_MIN_MAX_ABS_USE_IFs.o: USE_IFs/GET_VEC_MIN_MAX_ABS_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GPWG_PMOI_USE_IFs.o: USE_IFs/GPWG_PMOI_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GPWG_USERIN_USE_IFs.o: USE_IFs/GPWG_USERIN_USE_IFs.f90 obj/OURTIM_Interface.o obj/GET_ARRAY_ROW_NUM_Interface.o obj/EMG_Interface.o obj/OUTA_HERE_Interface.o obj/GPWG_PMOI_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GPWG_USE_IFs.o: USE_IFs/GPWG_USE_IFs.f90 obj/OURTIM_Interface.o obj/GET_ARRAY_ROW_NUM_Interface.o obj/EMG_Interface.o obj/GEN_T0L_Interface.o obj/MATMULT_FFF_Interface.o obj/GET_GRID_NUM_COMPS_Interface.o obj/OUTA_HERE_Interface.o obj/GPWG_PMOI_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GP_FORCE_BALANCE_PROC_USE_IFs.o: USE_IFs/GP_FORCE_BALANCE_PROC_USE_IFs.f90 obj/OURTIM_Interface.o obj/GET_GRID_AND_COMP_Interface.o obj/GET_GRID_NUM_COMPS_Interface.o obj/GET_ARRAY_ROW_NUM_Interface.o obj/GET_ELGP_Interface.o obj/GET_ELEM_AGRID_BGRID_Interface.o obj/EMG_Interface.o obj/ELEM_TRANSFORM_LBG_Interface.o obj/TDOF_COL_NUM_Interface.o obj/ELMDIS_Interface.o obj/CALC_ELEM_NODE_FORCES_Interface.o obj/TRANSFORM_NODE_FORCES_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GRAV_PROC_USE_IFs.o: USE_IFs/GRAV_PROC_USE_IFs.f90 obj/OURTIM_Interface.o obj/OPNERR_Interface.o obj/FILE_CLOSE_Interface.o obj/OUTA_HERE_Interface.o obj/READERR_Interface.o obj/GET_ARRAY_ROW_NUM_Interface.o obj/MATMULT_FFF_Interface.o obj/GEN_T0L_Interface.o obj/MATMULT_FFF_T_Interface.o obj/GET_GRID_6X6_MASS_Interface.o obj/TDOF_COL_NUM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GRID_ELEM_CONN_TABLE_USE_IFs.o: USE_IFs/GRID_ELEM_CONN_TABLE_USE_IFs.f90 obj/OURTIM_Interface.o obj/GET_ELEM_AGRID_BGRID_Interface.o obj/GET_ARRAY_ROW_NUM_Interface.o obj/ALLOCATE_MODEL_STUF_Interface.o obj/ARRAY_SIZE_ERROR_1_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GRID_PROC_USE_IFs.o: USE_IFs/GRID_PROC_USE_IFs.f90 obj/OURTIM_Interface.o obj/SORT_INT2_Interface.o obj/SORT_GRID_RGRID_Interface.o obj/OUTA_HERE_Interface.o obj/CORD_PROC_Interface.o obj/MATMULT_FFF_Interface.o obj/WRITE_GRID_COORDS_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/HEXA_USE_IFs.o: USE_IFs/HEXA_USE_IFs.f90 obj/OURTIM_Interface.o obj/MATMULT_FFF_Interface.o obj/ORDER_GAUSS_Interface.o obj/SHP3DH_Interface.o obj/JAC3D_Interface.o obj/B3D_ISOPARAMETRIC_Interface.o obj/MATMULT_FFF_T_Interface.o obj/OUTA_HERE_Interface.o obj/JAC2D_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/I4FLD_USE_IFs.o: USE_IFs/I4FLD_USE_IFs.f90
	$(F77) $(FLAGS) -c $< -o $@
obj/INDEP_FAILURE_INDEX_USE_IFs.o: USE_IFs/INDEP_FAILURE_INDEX_USE_IFs.f90 obj/OURTIM_Interface.o obj/GET_MACHINE_PARAMS_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/INTERFACE_FORCE_LTM_USE_IFs.o: USE_IFs/INTERFACE_FORCE_LTM_USE_IFs.f90 obj/OURTIM_Interface.o obj/SPARSE_MAT_DIAG_ZEROS_Interface.o obj/ALLOCATE_SPARSE_MAT_Interface.o obj/CRS_SYM_TO_CRS_NONSYM_Interface.o obj/OUTA_HERE_Interface.o obj/ALLOCATE_SCR_CRS_MAT_Interface.o obj/MERGE_MAT_COLS_SSS_Interface.o obj/DEALLOCATE_SCR_MAT_Interface.o obj/DEALLOCATE_SPARSE_MAT_Interface.o obj/WRITE_SPARSE_CRS_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/INVERT_EIGENS_USE_IFs.o: USE_IFs/INVERT_EIGENS_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/INVERT_FF_MAT_USE_IFs.o: USE_IFs/INVERT_FF_MAT_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/IP6CHK_USE_IFs.o: USE_IFs/IP6CHK_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/IS_ELEM_PCOMP_PROPS_USE_IFs.o: USE_IFs/IS_ELEM_PCOMP_PROPS_USE_IFs.f90
	$(F77) $(FLAGS) -c $< -o $@
obj/IS_THIS_A_RESTART_USE_IFs.o: USE_IFs/IS_THIS_A_RESTART_USE_IFs.f90 obj/OUTA_HERE_Interface.o obj/CSHIFT_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/JAC2D_USE_IFs.o: USE_IFs/JAC2D_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/JAC3D_USE_IFs.o: USE_IFs/JAC3D_USE_IFs.f90 obj/OURTIM_Interface.o obj/MATMULT_FFF_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/KGG_SINGULARITY_PROC_USE_IFs.o: USE_IFs/KGG_SINGULARITY_PROC_USE_IFs.f90 obj/OURTIM_Interface.o obj/TDOF_COL_NUM_Interface.o obj/GET_ARRAY_ROW_NUM_Interface.o obj/GET_GRID_NUM_COMPS_Interface.o obj/CONVERT_INT_TO_CHAR_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/KUSER1_USE_IFs.o: USE_IFs/KUSER1_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/LEFT_ADJ_BDFLD_USE_IFs.o: USE_IFs/LEFT_ADJ_BDFLD_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/LINK0_USE_IFs.o: USE_IFs/LINK0_USE_IFs.f90 obj/TIME_INIT_Interface.o obj/OURDAT_Interface.o obj/OURTIM_Interface.o obj/LOADC0_Interface.o obj/LOADB0_Interface.o obj/ALLOCATE_IN4_FILES_Interface.o obj/LOADE_Interface.o obj/ALLOCATE_NL_PARAMS_Interface.o obj/SET_FILE_CLOSE_STAT_Interface.o obj/ALLOCATE_MODEL_STUF_Interface.o obj/LOADC_Interface.o obj/READ_L1Z_Interface.o obj/LINK1_RESTART_DATA_Interface.o obj/LOADB_RESTART_Interface.o obj/SET_SPARSE_MAT_SYM_Interface.o obj/PRINT_CONSTANTS_1_Interface.o obj/GET_MACHINE_PARAMS_Interface.o obj/PRINT_ORDER_Interface.o obj/FILE_OPEN_Interface.o obj/LOADB_Interface.o obj/DEALLOCATE_MODEL_STUF_Interface.o obj/WRITE_EDAT_Interface.o obj/OUTA_HERE_Interface.o obj/WRITE_ENF_TO_L1O_Interface.o obj/FILE_CLOSE_Interface.o obj/ELESORT_Interface.o obj/ELEM_PROP_MATL_IIDS_Interface.o obj/GRID_PROC_Interface.o obj/GET_ELEM_AGRID_BGRID_Interface.o obj/SEQ_PROC_Interface.o obj/SUBCASE_PROC_Interface.o obj/GRID_ELEM_CONN_TABLE_Interface.o obj/CORD_PROC_Interface.o obj/WRITE_GRID_COORDS_Interface.o obj/ALLOCATE_DOF_TABLES_Interface.o obj/READ_DOF_TABLES_Interface.o obj/CALC_TDOF_ROW_START_Interface.o obj/WRITE_TSET_Interface.o obj/WRITE_TDOF_Interface.o obj/EMG_Interface.o obj/DOF_PROC_Interface.o obj/WRITE_USETSTR_Interface.o obj/CONM2_PROC_1_Interface.o obj/ALLOCATE_RBGLOBAL_Interface.o obj/GPWG_USERIN_Interface.o obj/GPWG_Interface.o obj/ALLOCATE_SPARSE_MAT_Interface.o obj/READ_MATRIX_1_Interface.o obj/PRT_MATS_ON_RESTART_Interface.o obj/DEALLOCATE_SPARSE_MAT_Interface.o obj/RB_DISP_MATRIX_PROC_Interface.o obj/GET_MATRIX_DIAG_STATS_Interface.o obj/STIFF_MAT_EQUIL_CHK_Interface.o obj/CONM2_PROC_2_Interface.o obj/TEMPERATURE_DATA_PROC_Interface.o obj/PRESSURE_DATA_PROC_Interface.o obj/TDOF_COL_NUM_Interface.o obj/ALLOCATE_COL_VEC_Interface.o obj/YS_ARRAY_Interface.o obj/DEALLOCATE_COL_VEC_Interface.o obj/WRITE_L1Z_Interface.o obj/OUTPUT4_MATRIX_MSGS_Interface.o obj/WRITE_L1A_Interface.o obj/CHK_ARRAY_ALLOC_STAT_Interface.o obj/WRITE_ALLOC_MEM_TABLE_Interface.o obj/FILE_INQUIRE_Interface.o obj/WRITE_EOFIL_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/LINK1_RESTART_DATA_USE_IFs.o: USE_IFs/LINK1_RESTART_DATA_USE_IFs.f90 obj/OURTIM_Interface.o obj/FILE_OPEN_Interface.o obj/READ_CHK_Interface.o obj/DATA_SET_NAME_ERROR_Interface.o obj/DATA_SET_SIZE_ERROR_Interface.o obj/FILE_CLOSE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/LINK1_USE_IFs.o: USE_IFs/LINK1_USE_IFs.f90 obj/TIME_INIT_Interface.o obj/OURDAT_Interface.o obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o obj/ALLOCATE_MODEL_STUF_Interface.o obj/FILE_OPEN_Interface.o obj/MPC_PROC_Interface.o obj/FILE_CLOSE_Interface.o obj/RIGID_ELEM_PROC_Interface.o obj/SPARSE_RMG_Interface.o obj/FORCE_MOM_PROC_Interface.o obj/EPTL_Interface.o obj/EMP0_Interface.o obj/ALLOCATE_EMS_ARRAYS_Interface.o obj/EMP_Interface.o obj/MGGC_MASS_MATRIX_Interface.o obj/ALLOCATE_L1_MGG_Interface.o obj/SPARSE_MGG_Interface.o obj/DEALLOCATE_EMS_ARRAYS_Interface.o obj/DEALLOCATE_L1_MGG_Interface.o obj/DEALLOCATE_MODEL_STUF_Interface.o obj/GRAV_PROC_Interface.o obj/RFORCE_PROC_Interface.o obj/SLOAD_PROC_Interface.o obj/SPARSE_PG_Interface.o obj/ESP0_Interface.o obj/ALLOCATE_STF_ARRAYS_Interface.o obj/ESP_Interface.o obj/DEALLOCATE_IN4_FILES_Interface.o obj/SPARSE_KGGD_Interface.o obj/DEALLOCATE_STF_ARRAYS_Interface.o obj/SPARSE_KGG_Interface.o obj/WRITE_DOF_TABLES_Interface.o obj/ELSAVE_Interface.o obj/CHK_ARRAY_ALLOC_STAT_Interface.o obj/WRITE_ALLOC_MEM_TABLE_Interface.o obj/WRITE_L1A_Interface.o obj/FILE_INQUIRE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/LINK2_USE_IFs.o: USE_IFs/LINK2_USE_IFs.f90 obj/TIME_INIT_Interface.o obj/OURDAT_Interface.o obj/OURTIM_Interface.o obj/READ_L1A_Interface.o obj/OUTA_HERE_Interface.o obj/GET_MATRIX_DIAG_STATS_Interface.o obj/STIFF_MAT_EQUIL_CHK_Interface.o obj/REDUCE_G_NM_Interface.o obj/REDUCE_N_FS_Interface.o obj/REDUCE_F_AO_Interface.o obj/WRITE_MATRIX_1_Interface.o obj/REDUCE_A_LR_Interface.o obj/DEALLOCATE_RBGLOBAL_Interface.o obj/OUTPUT4_PROC_Interface.o obj/WRITE_USERIN_BD_CARDS_Interface.o obj/WRITE_L1A_Interface.o obj/CHK_ARRAY_ALLOC_STAT_Interface.o obj/WRITE_ALLOC_MEM_TABLE_Interface.o obj/FILE_INQUIRE_Interface.o obj/DEALLOCATE_SPARSE_MAT_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/LINK3_USE_IFs.o: USE_IFs/LINK3_USE_IFs.f90 obj/TIME_INIT_Interface.o obj/OURDAT_Interface.o obj/OURTIM_Interface.o obj/READ_L1A_Interface.o obj/OUTA_HERE_Interface.o obj/SYM_MAT_DECOMP_LAPACK_Interface.o obj/ALLOCATE_COL_VEC_Interface.o obj/ALLOCATE_LAPACK_MAT_Interface.o obj/FILE_OPEN_Interface.o obj/GET_SPARSE_CRS_COL_Interface.o obj/WRITE_VECTOR_Interface.o obj/FBS_LAPACK_Interface.o obj/EPSCALC_Interface.o obj/VECINORM_Interface.o obj/DEALLOCATE_SPARSE_MAT_Interface.o obj/DEALLOCATE_LAPACK_MAT_Interface.o obj/DEALLOCATE_COL_VEC_Interface.o obj/FILE_CLOSE_Interface.o obj/WRITE_L1A_Interface.o obj/CHK_ARRAY_ALLOC_STAT_Interface.o obj/WRITE_ALLOC_MEM_TABLE_Interface.o obj/FILE_INQUIRE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/LINK4_USE_IFs.o: USE_IFs/LINK4_USE_IFs.f90 obj/TIME_INIT_Interface.o obj/OURDAT_Interface.o obj/OURTIM_Interface.o obj/READ_L1A_Interface.o obj/OUTA_HERE_Interface.o obj/READ_L1M_Interface.o obj/SPARSE_MAT_DIAG_ZEROS_Interface.o obj/ALLOCATE_SPARSE_MAT_Interface.o obj/CRS_SYM_TO_CRS_NONSYM_Interface.o obj/EIG_GIV_MGIV_Interface.o obj/EIG_INV_PWR_Interface.o obj/EIG_LANCZOS_ARPACK_Interface.o obj/DEALLOCATE_SPARSE_MAT_Interface.o obj/ALLOCATE_EIGEN1_MAT_Interface.o obj/CALC_GEN_MASS_Interface.o obj/RENORM_ON_MASS_Interface.o obj/WRITE_L1M_Interface.o obj/EIG_SUMMARY_Interface.o obj/FILE_OPEN_Interface.o obj/FILE_CLOSE_Interface.o obj/WRITE_VECTOR_Interface.o obj/OUTPUT4_PROC_Interface.o obj/DEALLOCATE_LAPACK_MAT_Interface.o obj/DEALLOCATE_EIGEN1_MAT_Interface.o obj/WRITE_L1A_Interface.o obj/CHK_ARRAY_ALLOC_STAT_Interface.o obj/WRITE_ALLOC_MEM_TABLE_Interface.o obj/FILE_INQUIRE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/LINK5_USE_IFs.o: USE_IFs/LINK5_USE_IFs.f90 obj/TIME_INIT_Interface.o obj/OURDAT_Interface.o obj/OURTIM_Interface.o obj/READ_L1A_Interface.o obj/OUTA_HERE_Interface.o obj/ALLOCATE_SPARSE_MAT_Interface.o obj/ALLOCATE_COL_VEC_Interface.o obj/READ_MATRIX_1_Interface.o obj/FILE_OPEN_Interface.o obj/READERR_Interface.o obj/FILE_CLOSE_Interface.o obj/ALLOCATE_EIGEN1_MAT_Interface.o obj/READ_L1M_Interface.o obj/ALLOCATE_FULL_MAT_Interface.o obj/TDOF_COL_NUM_Interface.o obj/BUILD_A_LR_Interface.o obj/DEALLOCATE_COL_VEC_Interface.o obj/BUILD_F_AO_Interface.o obj/BUILD_N_FS_Interface.o obj/BUILD_G_NM_Interface.o obj/DEALLOCATE_MISC_MAT_Interface.o obj/ALLOCATE_MISC_MAT_Interface.o obj/GET_UG_123_IN_GRD_ORD_Interface.o obj/RENORM_Interface.o obj/WRITE_L1M_Interface.o obj/EXPAND_PHIXA_TO_PHIXG_Interface.o obj/DEALLOCATE_SPARSE_MAT_Interface.o obj/GET_GRID_NUM_COMPS_Interface.o obj/EIG_SUMMARY_Interface.o obj/OUTPUT4_PROC_Interface.o obj/DEALLOCATE_EIGEN1_MAT_Interface.o obj/WRITE_L1A_Interface.o obj/CHK_ARRAY_ALLOC_STAT_Interface.o obj/WRITE_ALLOC_MEM_TABLE_Interface.o obj/FILE_INQUIRE_Interface.o obj/WRITE_FILNAM_Interface.o obj/I4FLD_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/LINK6_USE_IFs.o: USE_IFs/LINK6_USE_IFs.f90 obj/TIME_INIT_Interface.o obj/OURDAT_Interface.o obj/OURTIM_Interface.o obj/READ_L1A_Interface.o obj/OUTA_HERE_Interface.o obj/ALLOCATE_EIGEN1_MAT_Interface.o obj/READ_L1M_Interface.o obj/ALLOCATE_SPARSE_MAT_Interface.o obj/READ_MATRIX_1_Interface.o obj/FILE_OPEN_Interface.o obj/READERR_Interface.o obj/FILE_CLOSE_Interface.o obj/SOLVE_DLR_Interface.o obj/PARTITION_VEC_Interface.o obj/MERGE_PHIXA_Interface.o obj/WRITE_SPARSE_CRS_Interface.o obj/DEALLOCATE_SPARSE_MAT_Interface.o obj/CALC_PHIZL_Interface.o obj/CALC_KRRcb_Interface.o obj/MERGE_KXX_Interface.o obj/CALC_MRRcb_Interface.o obj/CALC_MRN_Interface.o obj/MERGE_MXX_Interface.o obj/INTERFACE_FORCE_LTM_Interface.o obj/NET_CG_LOADS_LTM_Interface.o obj/MERGE_LTM_Interface.o obj/GET_SPARSE_CRS_COL_Interface.o obj/CALC_CB_MEFM_MPF_Interface.o obj/OUTPUT4_PROC_Interface.o obj/WRITE_USERIN_BD_CARDS_Interface.o obj/DEALLOCATE_EIGEN1_MAT_Interface.o obj/DEALLOCATE_LAPACK_MAT_Interface.o obj/WRITE_L1A_Interface.o obj/CHK_ARRAY_ALLOC_STAT_Interface.o obj/WRITE_ALLOC_MEM_TABLE_Interface.o obj/FILE_INQUIRE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/LINK9S_USE_IFs.o: USE_IFs/LINK9S_USE_IFs.f90 obj/OURTIM_Interface.o obj/FILE_OPEN_Interface.o obj/READ_CHK_Interface.o obj/DATA_SET_NAME_ERROR_Interface.o obj/DATA_SET_SIZE_ERROR_Interface.o obj/FILE_CLOSE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/LINK9_USE_IFs.o: USE_IFs/LINK9_USE_IFs.f90 obj/TIME_INIT_Interface.o obj/OURDAT_Interface.o obj/OURTIM_Interface.o obj/FILE_OPEN_Interface.o obj/READ_L1A_Interface.o obj/OUTA_HERE_Interface.o obj/DEALLOCATE_MODEL_STUF_Interface.o obj/ALLOCATE_MODEL_STUF_Interface.o obj/LINK9S_Interface.o obj/MAXREQ_OGEL_Interface.o obj/ALLOCATE_SPARSE_MAT_Interface.o obj/READ_MATRIX_1_Interface.o obj/PARTITION_VEC_Interface.o obj/PARTITION_SS_NTERM_Interface.o obj/PARTITION_SS_Interface.o obj/ALLOCATE_COL_VEC_Interface.o obj/GET_SPARSE_CRS_COL_Interface.o obj/MATTRNSP_SS_Interface.o obj/ALLOCATE_EIGEN1_MAT_Interface.o obj/READ_L1M_Interface.o obj/DEALLOCATE_EIGEN1_MAT_Interface.o obj/ALLOCATE_LINK9_STUF_Interface.o obj/ALLOCATE_CB_GRD_OTM_Interface.o obj/ALLOCATE_CB_ELM_OTM_Interface.o obj/DEALLOCATE_COL_VEC_Interface.o obj/READERR_Interface.o obj/OFP1_Interface.o obj/OFP2_Interface.o obj/MATMULT_SFF_Interface.o obj/TDOF_COL_NUM_Interface.o obj/GP_FORCE_BALANCE_PROC_Interface.o obj/OFP3_Interface.o obj/FILE_CLOSE_Interface.o obj/WRITE_OU4_FULL_MAT_Interface.o obj/WRITE_GRD_OT4_Interface.o obj/WRITE_ELM_OT4_Interface.o obj/WRITE_MPFACTOR_Interface.o obj/WRITE_MEFFMASS_Interface.o obj/OUTPUT4_PROC_Interface.o obj/DEALLOCATE_SPARSE_MAT_Interface.o obj/DEALLOCATE_IN4_FILES_Interface.o obj/DEALLOCATE_LINK9_STUF_Interface.o obj/WRITE_L1A_Interface.o obj/FILE_INQUIRE_Interface.o obj/CHK_ARRAY_ALLOC_STAT_Interface.o obj/WRITE_ALLOC_MEM_TABLE_Interface.o obj/MERGE_COL_VECS_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/LOADB0_USE_IFs.o: USE_IFs/LOADB0_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o obj/FFIELD_Interface.o obj/FFIELD2_Interface.o obj/BD_BAROR0_Interface.o obj/BD_BEAMOR0_Interface.o obj/BD_CBAR0_Interface.o obj/BD_CBUSH0_Interface.o obj/BD_CHEXA0_Interface.o obj/BD_CPENTA0_Interface.o obj/BD_CQUAD0_Interface.o obj/BD_CTETRA0_Interface.o obj/BD_CTRIA0_Interface.o obj/BD_CUSERIN0_Interface.o obj/BD_DEBUG0_Interface.o obj/BD_GRDSET0_Interface.o obj/BD_LOAD0_Interface.o obj/BD_MPC0_Interface.o obj/BD_MPCADD0_Interface.o obj/BD_PARAM0_Interface.o obj/BD_PCOMP0_Interface.o obj/BD_PCOMP10_Interface.o obj/BD_RBE30_Interface.o obj/BD_RSPLINE0_Interface.o obj/BD_SLOAD0_Interface.o obj/BD_SPCADD0_Interface.o obj/BD_SPOINT0_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/LOADB_RESTART_USE_IFs.o: USE_IFs/LOADB_RESTART_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o obj/FFIELD_Interface.o obj/FFIELD2_Interface.o obj/MKJCARD_Interface.o obj/I4FLD_Interface.o obj/MKCARD_Interface.o obj/BD_PARAM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/LOADB_USE_IFs.o: USE_IFs/LOADB_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o obj/FFIELD_Interface.o obj/FFIELD2_Interface.o obj/BD_ASET_Interface.o obj/BD_ASET1_Interface.o obj/BD_BAROR_Interface.o obj/BD_BEAMOR_Interface.o obj/BD_CBAR_Interface.o obj/BD_CBUSH_Interface.o obj/BD_CELAS1_Interface.o obj/BD_CELAS2_Interface.o obj/BD_CELAS3_Interface.o obj/BD_CELAS4_Interface.o obj/BD_CHEXA_Interface.o obj/BD_CMASS1_Interface.o obj/BD_CMASS2_Interface.o obj/BD_CMASS3_Interface.o obj/BD_CMASS4_Interface.o obj/BD_CONROD_Interface.o obj/BD_CONM2_Interface.o obj/BD_CORD_Interface.o obj/BD_CPENTA_Interface.o obj/BD_CQUAD_Interface.o obj/BD_CROD_Interface.o obj/BD_CSHEAR_Interface.o obj/BD_CTETRA_Interface.o obj/BD_CTRIA_Interface.o obj/BD_CUSER1_Interface.o obj/BD_CUSERIN_Interface.o obj/BD_DEBUG_Interface.o obj/BD_EIGR_Interface.o obj/BD_EIGRL_Interface.o obj/BD_FORMOM_Interface.o obj/BD_GRAV_Interface.o obj/BD_GRDSET_Interface.o obj/BD_GRID_Interface.o obj/BD_LOAD_Interface.o obj/BD_MAT1_Interface.o obj/BD_MAT2_Interface.o obj/BD_MAT8_Interface.o obj/BD_MAT9_Interface.o obj/BD_MPC_Interface.o obj/BD_MPCADD_Interface.o obj/BD_NLPARM_Interface.o obj/BD_PARAM_Interface.o obj/BD_PARVEC_Interface.o obj/BD_PARVEC1_Interface.o obj/BD_PBAR_Interface.o obj/BD_PBARL_Interface.o obj/BD_PBEAM_Interface.o obj/BD_PBUSH_Interface.o obj/BD_PCOMP_Interface.o obj/BD_PCOMP1_Interface.o obj/BD_PELAS_Interface.o obj/BD_PLOAD4_Interface.o obj/BD_PLOAD2_Interface.o obj/BD_PLOTEL_Interface.o obj/BD_PMASS_Interface.o obj/BD_PROD_Interface.o obj/BD_PSHEAR_Interface.o obj/BD_PSHEL_Interface.o obj/BD_PSOLID_Interface.o obj/BD_PUSER1_Interface.o obj/BD_PUSERIN_Interface.o obj/BD_RBAR_Interface.o obj/BD_RBE1_Interface.o obj/BD_RBE2_Interface.o obj/BD_RBE3_Interface.o obj/BD_RFORCE_Interface.o obj/BD_RSPLINE_Interface.o obj/BD_SEQGP_Interface.o obj/BD_SLOAD_Interface.o obj/BD_SPC_Interface.o obj/BD_SPC1_Interface.o obj/BD_SPCADD_Interface.o obj/BD_SPOINT_Interface.o obj/BD_SUPORT_Interface.o obj/BD_TEMP_Interface.o obj/BD_TEMPD_Interface.o obj/BD_TEMPRP_Interface.o obj/BD_USET_Interface.o obj/BD_USET1_Interface.o obj/ALLOCATE_MODEL_STUF_Interface.o obj/SORT_INT1_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/LOADC0_USE_IFs.o: USE_IFs/LOADC0_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o obj/REPLACE_TABS_W_BLANKS_Interface.o obj/CSHIFT_Interface.o obj/CC_SET0_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/LOADC_USE_IFs.o: USE_IFs/LOADC_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o obj/REPLACE_TABS_W_BLANKS_Interface.o obj/CSHIFT_Interface.o obj/CC_ACCE_Interface.o obj/CC_DISP_Interface.o obj/CC_ECHO_Interface.o obj/CC_ELDA_Interface.o obj/CC_ELFO_Interface.o obj/CC_ENFO_Interface.o obj/CC_GPFO_Interface.o obj/CC_LABE_Interface.o obj/CC_LOAD_Interface.o obj/CC_METH_Interface.o obj/CC_MPC_Interface.o obj/CC_MPCF_Interface.o obj/CC_NLPARM_Interface.o obj/CC_OLOA_Interface.o obj/CC_SET_Interface.o obj/CC_SPC_Interface.o obj/CC_SPCF_Interface.o obj/CC_STRN_Interface.o obj/CC_STRE_Interface.o obj/CC_SUBC_Interface.o obj/CC_SUBT_Interface.o obj/CC_TEMP_Interface.o obj/CC_TITL_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/LOADE0_USE_IFs.o: USE_IFs/LOADE0_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o obj/REPLACE_TABS_W_BLANKS_Interface.o obj/CSHIFT_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/LOADE_USE_IFs.o: USE_IFs/LOADE_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o obj/REPLACE_TABS_W_BLANKS_Interface.o obj/CSHIFT_Interface.o obj/EC_DEBUG_Interface.o obj/EC_IN4FIL_Interface.o obj/EC_OUTPUT4_Interface.o obj/EC_PARTN_Interface.o obj/STOKEN_Interface.o obj/I4FLD_Interface.o obj/CRDERR_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MATADD_FFF_USE_IFs.o: USE_IFs/MATADD_FFF_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MATADD_SSS_NTERM_USE_IFs.o: USE_IFs/MATADD_SSS_NTERM_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o obj/ALLOCATE_SPARSE_ALG_Interface.o obj/DEALLOCATE_SPARSE_ALG_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MATADD_SSS_USE_IFs.o: USE_IFs/MATADD_SSS_USE_IFs.f90 obj/OURTIM_Interface.o obj/ALLOCATE_SPARSE_ALG_Interface.o obj/ARRAY_SIZE_ERROR_1_Interface.o obj/DEALLOCATE_SPARSE_ALG_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MATERIAL_PROPS_2D_USE_IFs.o: USE_IFs/MATERIAL_PROPS_2D_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MATERIAL_PROPS_3D_USE_IFs.o: USE_IFs/MATERIAL_PROPS_3D_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MATGET_USE_IFs.o: USE_IFs/MATGET_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MATMULT_FFF_T_USE_IFs.o: USE_IFs/MATMULT_FFF_T_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MATMULT_FFF_USE_IFs.o: USE_IFs/MATMULT_FFF_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MATMULT_SFF_USE_IFs.o: USE_IFs/MATMULT_SFF_USE_IFs.f90 obj/OURTIM_Interface.o obj/ALLOCATE_SPARSE_ALG_Interface.o obj/DEALLOCATE_SPARSE_ALG_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MATMULT_SFS_NTERM_USE_IFs.o: USE_IFs/MATMULT_SFS_NTERM_USE_IFs.f90 obj/OURTIM_Interface.o obj/ALLOCATE_SPARSE_ALG_Interface.o obj/ROW_AT_COLJ_BEGEND_Interface.o obj/DEALLOCATE_SPARSE_ALG_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MATMULT_SFS_USE_IFs.o: USE_IFs/MATMULT_SFS_USE_IFs.f90 obj/OURTIM_Interface.o obj/ROW_AT_COLJ_BEGEND_Interface.o obj/ARRAY_SIZE_ERROR_1_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MATMULT_SSS_NTERM_USE_IFs.o: USE_IFs/MATMULT_SSS_NTERM_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o obj/ALLOCATE_SPARSE_ALG_Interface.o obj/ROW_AT_COLJ_BEGEND_Interface.o obj/DEALLOCATE_SPARSE_ALG_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MATMULT_SSS_USE_IFs.o: USE_IFs/MATMULT_SSS_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o obj/ROW_AT_COLJ_BEGEND_Interface.o obj/ARRAY_SIZE_ERROR_1_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MATPUT_USE_IFs.o: USE_IFs/MATPUT_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MATTRNSP_SS_USE_IFs.o: USE_IFs/MATTRNSP_SS_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MAXREQ_OGEL_USE_IFs.o: USE_IFs/MAXREQ_OGEL_USE_IFs.f90 obj/OURTIM_Interface.o obj/IS_ELEM_PCOMP_PROPS_Interface.o obj/GET_ELEM_NUM_PLIES_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MERGE_COL_VECS_USE_IFs.o: USE_IFs/MERGE_COL_VECS_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MERGE_KXX_USE_IFs.o: USE_IFs/MERGE_KXX_USE_IFs.f90 obj/OURTIM_Interface.o obj/ALLOCATE_SPARSE_MAT_Interface.o obj/WRITE_SPARSE_CRS_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MERGE_LTM_USE_IFs.o: USE_IFs/MERGE_LTM_USE_IFs.f90 obj/OURTIM_Interface.o obj/ALLOCATE_SPARSE_MAT_Interface.o obj/MERGE_MAT_ROWS_SSS_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MERGE_MAT_COLS_SSS_USE_IFs.o: USE_IFs/MERGE_MAT_COLS_SSS_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o obj/ARRAY_SIZE_ERROR_1_Interface.o obj/SORT_INT1_REAL1_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MERGE_MAT_ROWS_SSS_USE_IFs.o: USE_IFs/MERGE_MAT_ROWS_SSS_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MERGE_MXX_USE_IFs.o: USE_IFs/MERGE_MXX_USE_IFs.f90 obj/OURTIM_Interface.o obj/ALLOCATE_SPARSE_MAT_Interface.o obj/CRS_SYM_TO_CRS_NONSYM_Interface.o obj/OUTA_HERE_Interface.o obj/MERGE_MAT_COLS_SSS_Interface.o obj/MATTRNSP_SS_Interface.o obj/MERGE_MAT_ROWS_SSS_Interface.o obj/CRS_NONSYM_TO_CRS_SYM_Interface.o obj/DEALLOCATE_SPARSE_MAT_Interface.o obj/WRITE_SPARSE_CRS_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MERGE_PHIXA_USE_IFs.o: USE_IFs/MERGE_PHIXA_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MGGC_MASS_MATRIX_USE_IFs.o: USE_IFs/MGGC_MASS_MATRIX_USE_IFs.f90 obj/OURTIM_Interface.o obj/ALLOCATE_L1_MGG_Interface.o obj/GET_GRID_NUM_COMPS_Interface.o obj/ARRAY_SIZE_ERROR_1_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MGGS_MASS_MATRIX_USE_IFs.o: USE_IFs/MGGS_MASS_MATRIX_USE_IFs.f90 obj/OURTIM_Interface.o obj/ALLOCATE_L1_MGG_Interface.o obj/TDOF_COL_NUM_Interface.o obj/GET_ARRAY_ROW_NUM_Interface.o obj/OUTA_HERE_Interface.o obj/SORT_INT2_REAL1_Interface.o obj/ARRAY_SIZE_ERROR_1_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MIN4SH_USE_IFs.o: USE_IFs/MIN4SH_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MKCARD_USE_IFs.o: USE_IFs/MKCARD_USE_IFs.f90
	$(F77) $(FLAGS) -c $< -o $@
obj/MKJCARD_08_USE_IFs.o: USE_IFs/MKJCARD_08_USE_IFs.f90
	$(F77) $(FLAGS) -c $< -o $@
obj/MKJCARD_USE_IFs.o: USE_IFs/MKJCARD_USE_IFs.f90
	$(F77) $(FLAGS) -c $< -o $@
obj/MPC_PROC_USE_IFs.o: USE_IFs/MPC_PROC_USE_IFs.f90 obj/OURTIM_Interface.o obj/TDOF_COL_NUM_Interface.o obj/READERR_Interface.o obj/OUTA_HERE_Interface.o obj/GET_ARRAY_ROW_NUM_Interface.o obj/DEALLOCATE_MODEL_STUF_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MYSTRAN_FILES_USE_IFs.o: USE_IFs/MYSTRAN_FILES_USE_IFs.f90 obj/FILE_OPEN_Interface.o obj/FILE_CLOSE_Interface.o obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MYSTRAN_USE_IFs.o: USE_IFs/MYSTRAN_USE_IFs.f90 obj/TIME_INIT_Interface.o obj/OURTIM_Interface.o obj/OURDAT_Interface.o obj/READ_INI_Interface.o obj/READ_INPUT_FILE_NAME_Interface.o obj/WRITE_FILNAM_Interface.o obj/FILE_OPEN_Interface.o obj/IS_THIS_A_RESTART_Interface.o obj/MYSTRAN_FILES_Interface.o obj/PROCESS_INCLUDE_FILES_Interface.o obj/FILE_CLOSE_Interface.o obj/LOADE0_Interface.o obj/READ_L1A_Interface.o obj/LINK0_Interface.o obj/LINK1_Interface.o obj/LINK2_Interface.o obj/LINK3_Interface.o obj/LINK4_Interface.o obj/LINK6_Interface.o obj/DEALLOCATE_RBGLOBAL_Interface.o obj/LINK5_Interface.o obj/OUTA_HERE_Interface.o obj/LINK9_Interface.o obj/RESTART_DATA_FOR_L3_Interface.o obj/DEALLOCATE_NL_PARAMS_Interface.o obj/FILE_INQUIRE_Interface.o obj/CLOSE_OUTFILES_Interface.o obj/CLOSE_LIJFILES_Interface.o obj/VECTOR_NORM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/NET_CG_LOADS_LTM_USE_IFs.o: USE_IFs/NET_CG_LOADS_LTM_USE_IFs.f90 obj/OURTIM_Interface.o obj/MATMULT_SFF_Interface.o obj/MATMULT_FFF_T_Interface.o obj/INVERT_FF_MAT_Interface.o obj/MATMULT_FFF_Interface.o obj/CNT_NONZ_IN_FULL_MAT_Interface.o obj/ALLOCATE_SCR_CRS_MAT_Interface.o obj/FULL_TO_SPARSE_CRS_Interface.o obj/MERGE_MAT_COLS_SSS_Interface.o obj/ALLOCATE_SCR_CCS_MAT_Interface.o obj/SPARSE_CRS_SPARSE_CCS_Interface.o obj/DEALLOCATE_SCR_MAT_Interface.o obj/MATMULT_SSS_NTERM_Interface.o obj/ALLOCATE_SPARSE_MAT_Interface.o obj/MATMULT_SSS_Interface.o obj/WRITE_SPARSE_CRS_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/NEXTC0_USE_IFs.o: USE_IFs/NEXTC0_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/READERR_Interface.o obj/FFIELD_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/NEXTC20_USE_IFs.o: USE_IFs/NEXTC20_USE_IFs.f90 obj/MKJCARD_Interface.o obj/READERR_Interface.o obj/FFIELD2_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/NEXTC2_USE_IFs.o: USE_IFs/NEXTC2_USE_IFs.f90 obj/MKJCARD_Interface.o obj/READERR_Interface.o obj/FFIELD2_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/NEXTC_USE_IFs.o: USE_IFs/NEXTC_USE_IFs.f90 obj/OURTIM_Interface.o obj/MKJCARD_Interface.o obj/READERR_Interface.o obj/FFIELD_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/OFP1_USE_IFs.o: USE_IFs/OFP1_USE_IFs.f90 obj/OURTIM_Interface.o obj/GET_ARRAY_ROW_NUM_Interface.o obj/GET_GRID_NUM_COMPS_Interface.o obj/TDOF_COL_NUM_Interface.o obj/WRITE_GRD_PCH_OUTPUTS_Interface.o obj/WRITE_GRD_PRT_OUTPUTS_Interface.o obj/WRITE_FEMAP_GRID_VECS_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/OFP2_USE_IFs.o: USE_IFs/OFP2_USE_IFs.f90 obj/OURTIM_Interface.o obj/ALLOCATE_COL_VEC_Interface.o obj/TDOF_COL_NUM_Interface.o obj/MATMULT_SFF_Interface.o obj/DEALLOCATE_COL_VEC_Interface.o obj/GET_ARRAY_ROW_NUM_Interface.o obj/GET_GRID_NUM_COMPS_Interface.o obj/WRITE_GRD_PCH_OUTPUTS_Interface.o obj/WRITE_GRD_PRT_OUTPUTS_Interface.o obj/CONVERT_VEC_COORD_SYS_Interface.o obj/WRITE_FEMAP_GRID_VECS_Interface.o obj/MERGE_COL_VECS_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/OFP3_ELFE_1D_USE_IFs.o: USE_IFs/OFP3_ELFE_1D_USE_IFs.f90 obj/OURTIM_Interface.o obj/EMG_Interface.o obj/ELMDIS_Interface.o obj/CALC_ELEM_NODE_FORCES_Interface.o obj/OUTA_HERE_Interface.o obj/ELEM_STRE_STRN_ARRAYS_Interface.o obj/CALC_ELEM_STRESSES_Interface.o obj/WRITE_ELEM_ENGR_FORCE_Interface.o obj/ALLOCATE_FEMAP_DATA_Interface.o obj/WRITE_FEMAP_ELFO_VECS_Interface.o obj/DEALLOCATE_FEMAP_DATA_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/OFP3_ELFE_2D_USE_IFs.o: USE_IFs/OFP3_ELFE_2D_USE_IFs.f90 obj/OURTIM_Interface.o obj/is_elem_pcomp_props_Interface.o obj/EMG_Interface.o obj/ELMDIS_Interface.o obj/ELEM_STRE_STRN_ARRAYS_Interface.o obj/SHELL_ENGR_FORCE_OGEL_Interface.o obj/WRITE_ELEM_ENGR_FORCE_Interface.o obj/ALLOCATE_FEMAP_DATA_Interface.o obj/WRITE_FEMAP_ELFO_VECS_Interface.o obj/DEALLOCATE_FEMAP_DATA_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/OFP3_ELFN_USE_IFs.o: USE_IFs/OFP3_ELFN_USE_IFs.f90 obj/OURTIM_Interface.o obj/EMG_Interface.o obj/ELMDIS_Interface.o obj/CALC_ELEM_NODE_FORCES_Interface.o obj/TRANSFORM_NODE_FORCES_Interface.o obj/ELMOUT_Interface.o obj/OUTA_HERE_Interface.o obj/GET_GRID_NUM_COMPS_Interface.o obj/WRITE_ELEM_NODE_FORCE_Interface.o obj/WRITE_EOFIL_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/OFP3_STRE_NO_PCOMP_USE_IFs.o: USE_IFs/OFP3_STRE_NO_PCOMP_USE_IFs.f90 obj/OURTIM_Interface.o obj/IS_ELEM_PCOMP_PROPS_Interface.o obj/EMG_Interface.o obj/ELMDIS_Interface.o obj/ELEM_STRE_STRN_ARRAYS_Interface.o obj/POLYNOM_FIT_STRE_STRN_Interface.o obj/CALC_ELEM_STRESSES_Interface.o obj/WRITE_ELEM_STRESSES_Interface.o obj/ALLOCATE_FEMAP_DATA_Interface.o obj/WRITE_FEMAP_STRE_VECS_Interface.o obj/DEALLOCATE_FEMAP_DATA_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/OFP3_STRE_PCOMP_USE_IFs.o: USE_IFs/OFP3_STRE_PCOMP_USE_IFs.f90 obj/OURTIM_Interface.o obj/IS_ELEM_PCOMP_PROPS_Interface.o obj/GET_ELEM_NUM_PLIES_Interface.o obj/EMG_Interface.o obj/ELMDIS_Interface.o obj/ELMDIS_PLY_Interface.o obj/SUSER1_Interface.o obj/ELEM_STRE_STRN_ARRAYS_Interface.o obj/ROT_COMP_ELEM_AXES_Interface.o obj/CALC_ELEM_STRESSES_Interface.o obj/WRITE_PLY_STRESSES_Interface.o obj/ALLOCATE_FEMAP_DATA_Interface.o obj/WRITE_FEMAP_STRE_VECS_Interface.o obj/DEALLOCATE_FEMAP_DATA_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/OFP3_STRN_NO_PCOMP_USE_IFs.o: USE_IFs/OFP3_STRN_NO_PCOMP_USE_IFs.f90 obj/OURTIM_Interface.o obj/IS_ELEM_PCOMP_PROPS_Interface.o obj/EMG_Interface.o obj/ELMDIS_Interface.o obj/ELEM_STRE_STRN_ARRAYS_Interface.o obj/POLYNOM_FIT_STRE_STRN_Interface.o obj/CALC_ELEM_STRAINS_Interface.o obj/WRITE_ELEM_STRAINS_Interface.o obj/ALLOCATE_FEMAP_DATA_Interface.o obj/WRITE_FEMAP_STRN_VECS_Interface.o obj/DEALLOCATE_FEMAP_DATA_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/OFP3_STRN_PCOMP_USE_IFs.o: USE_IFs/OFP3_STRN_PCOMP_USE_IFs.f90 obj/OURTIM_Interface.o obj/IS_ELEM_PCOMP_PROPS_Interface.o obj/GET_ELEM_NUM_PLIES_Interface.o obj/EMG_Interface.o obj/ELMDIS_Interface.o obj/ELMDIS_PLY_Interface.o obj/SUSER1_Interface.o obj/ELEM_STRE_STRN_ARRAYS_Interface.o obj/ROT_COMP_ELEM_AXES_Interface.o obj/CALC_ELEM_STRAINS_Interface.o obj/WRITE_PLY_STRAINS_Interface.o obj/ALLOCATE_FEMAP_DATA_Interface.o obj/WRITE_FEMAP_STRN_VECS_Interface.o obj/DEALLOCATE_FEMAP_DATA_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/OFP3_USE_IFs.o: USE_IFs/OFP3_USE_IFs.f90 obj/OURTIM_Interface.o obj/OFP3_ELFN_Interface.o obj/OFP3_ELFE_1D_Interface.o obj/OFP3_ELFE_2D_Interface.o obj/OFP3_STRE_PCOMP_Interface.o obj/OFP3_STRE_NO_PCOMP_Interface.o obj/OFP3_STRN_PCOMP_Interface.o obj/OFP3_STRN_NO_PCOMP_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ONE_D_STRAIN_OUTPUTS_USE_IFs.o: USE_IFs/ONE_D_STRAIN_OUTPUTS_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ONE_D_STRESS_OUTPUTS_USE_IFs.o: USE_IFs/ONE_D_STRESS_OUTPUTS_USE_IFs.f90 obj/OURTIM_Interface.o obj/BAR_MARGIN_Interface.o obj/OUTA_HERE_Interface.o obj/ROD_MARGIN_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/OPEN_OUTFILES_USE_IFs.o: USE_IFs/OPEN_OUTFILES_USE_IFs.f90 obj/FILERR_Interface.o obj/OUTA_HERE_Interface.o obj/FILE_OPEN_Interface.o obj/FILE_CLOSE_Interface.o obj/WRITE_FILNAM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/OPNERR_USE_IFs.o: USE_IFs/OPNERR_USE_IFs.f90 obj/OURTIM_Interface.o obj/WRITE_FILNAM_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ORDER_GAUSS_USE_IFs.o: USE_IFs/ORDER_GAUSS_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ORDER_TETRA_USE_IFs.o: USE_IFs/ORDER_TETRA_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ORDER_TRIA_USE_IFs.o: USE_IFs/ORDER_TRIA_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/OU4_PARTVEC_PROC_USE_IFs.o: USE_IFs/OU4_PARTVEC_PROC_USE_IFs.f90 obj/OURTIM_Interface.o obj/DEALLOCATE_COL_VEC_Interface.o obj/OUTA_HERE_Interface.o obj/FILE_OPEN_Interface.o obj/READERR_Interface.o obj/RDOF_Interface.o obj/GET_ARRAY_ROW_NUM_Interface.o obj/GET_GRID_NUM_COMPS_Interface.o obj/FILE_CLOSE_Interface.o obj/TDOF_COL_NUM_Interface.o obj/ALLOCATE_COL_VEC_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/OURDAT_USE_IFs.o: USE_IFs/OURDAT_USE_IFs.f90
	$(F77) $(FLAGS) -c $< -o $@
obj/OURTIM_USE_IFs.o: USE_IFs/OURTIM_USE_IFs.f90
	$(F77) $(FLAGS) -c $< -o $@
obj/OUTA_HERE_USE_IFs.o: USE_IFs/OUTA_HERE_USE_IFs.f90 obj/OURTIM_Interface.o obj/WRITE_FILNAM_Interface.o obj/WRITE_L1A_Interface.o obj/CLOSE_OUTFILES_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/OUTPUT4_MATRIX_MSGS_USE_IFs.o: USE_IFs/OUTPUT4_MATRIX_MSGS_USE_IFs.f90 obj/FILE_OPEN_Interface.o obj/FILE_CLOSE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/OUTPUT4_PROC_USE_IFs.o: USE_IFs/OUTPUT4_PROC_USE_IFs.f90 obj/OURTIM_Interface.o obj/GET_OU4_MAT_STATS_Interface.o obj/OU4_PARTVEC_PROC_Interface.o obj/WRITE_PARTNd_MAT_HDRS_Interface.o obj/PARTITION_SS_NTERM_Interface.o obj/ALLOCATE_SCR_CRS_MAT_Interface.o obj/PARTITION_SS_Interface.o obj/WRITE_OU4_SPARSE_MAT_Interface.o obj/ALLOCATE_FULL_MAT_Interface.o obj/PARTITION_FF_Interface.o obj/WRITE_OU4_FULL_MAT_Interface.o obj/OUTA_HERE_Interface.o obj/DEALLOCATE_SCR_MAT_Interface.o obj/DEALLOCATE_FULL_MAT_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/PARAM_CORDS_ACT_CORDS_USE_IFs.o: USE_IFs/PARAM_CORDS_ACT_CORDS_USE_IFs.f90 obj/OURTIM_Interface.o obj/outa_here_Interface.o obj/SHP2DQ_Interface.o obj/MATMULT_FFF_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/PARSE_CHAR_STRING_USE_IFs.o: USE_IFs/PARSE_CHAR_STRING_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/PARTITION_FF_USE_IFs.o: USE_IFs/PARTITION_FF_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/PARTITION_SS_NTERM_USE_IFs.o: USE_IFs/PARTITION_SS_NTERM_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o obj/ROW_AT_COLJ_BEGEND_Interface.o obj/ALLOCATE_SPARSE_ALG_Interface.o obj/DEALLOCATE_SPARSE_ALG_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/PARTITION_SS_USE_IFs.o: USE_IFs/PARTITION_SS_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o obj/ROW_AT_COLJ_BEGEND_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/PARTITION_VEC_USE_IFs.o: USE_IFs/PARTITION_VEC_USE_IFs.f90 obj/OURTIM_Interface.o obj/TDOF_COL_NUM_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/PENTA_USE_IFs.o: USE_IFs/PENTA_USE_IFs.f90 obj/OURTIM_Interface.o obj/ORDER_TRIA_Interface.o obj/ORDER_GAUSS_Interface.o obj/SHP3DP_Interface.o obj/JAC3D_Interface.o obj/MATMULT_FFF_Interface.o obj/B3D_ISOPARAMETRIC_Interface.o obj/MATMULT_FFF_T_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/PINFLG_USE_IFs.o: USE_IFs/PINFLG_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/PLANE_COORD_TRANS_21_USE_IFs.o: USE_IFs/PLANE_COORD_TRANS_21_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/POLYNOM_FIT_STRE_STRN_USE_IFs.o: USE_IFs/POLYNOM_FIT_STRE_STRN_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o obj/ORDER_GAUSS_Interface.o obj/PARAM_CORDS_ACT_CORDS_Interface.o obj/SURFACE_FIT_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/POLY_FAILURE_INDEX_USE_IFs.o: USE_IFs/POLY_FAILURE_INDEX_USE_IFs.f90 obj/OURTIM_Interface.o obj/GET_MACHINE_PARAMS_Interface.o obj/MATMULT_FFF_Interface.o obj/MATMULT_FFF_T_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/PRESSURE_DATA_PROC_USE_IFs.o: USE_IFs/PRESSURE_DATA_PROC_USE_IFs.f90 obj/OURTIM_Interface.o obj/READERR_Interface.o obj/MKJCARD_Interface.o obj/OUTA_HERE_Interface.o obj/TOKCHK_Interface.o obj/FILE_CLOSE_Interface.o obj/FILE_OPEN_Interface.o obj/GET_ARRAY_ROW_NUM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/PRINCIPAL_2D_USE_IFs.o: USE_IFs/PRINCIPAL_2D_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/PRINCIPAL_3D_USE_IFs.o: USE_IFs/PRINCIPAL_3D_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/PRINT_CONSTANTS_1_USE_IFs.o: USE_IFs/PRINT_CONSTANTS_1_USE_IFs.f90
	$(F77) $(FLAGS) -c $< -o $@
obj/PRINT_ORDER_USE_IFs.o: USE_IFs/PRINT_ORDER_USE_IFs.f90 obj/ORDER_GAUSS_Interface.o obj/ORDER_TRIA_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/PROCESS_INCLUDE_FILES_USE_IFs.o: USE_IFs/PROCESS_INCLUDE_FILES_USE_IFs.f90 obj/OURTIM_Interface.o obj/CSHIFT_Interface.o obj/READ_INCLUDE_FILNAM_Interface.o obj/RW_INCLUDE_FILES_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/PROJ_VEC_ONTO_PLANE_USE_IFs.o: USE_IFs/PROJ_VEC_ONTO_PLANE_USE_IFs.f90 obj/OURTIM_Interface.o obj/CROSS_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/PRT_MATS_ON_RESTART_USE_IFs.o: USE_IFs/PRT_MATS_ON_RESTART_USE_IFs.f90 obj/OURTIM_Interface.o obj/ALLOCATE_SPARSE_MAT_Interface.o obj/READ_MATRIX_1_Interface.o obj/WRITE_SPARSE_CRS_Interface.o obj/DEALLOCATE_SPARSE_MAT_Interface.o obj/FILE_OPEN_Interface.o obj/ALLOCATE_COL_VEC_Interface.o obj/READERR_Interface.o obj/OUTA_HERE_Interface.o obj/WRITE_VECTOR_Interface.o obj/FILE_CLOSE_Interface.o obj/DEALLOCATE_COL_VEC_Interface.o obj/GET_MATRIX_DIAG_STATS_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/QDEL1_USE_IFs.o: USE_IFs/QDEL1_USE_IFs.f90 obj/OURTIM_Interface.o obj/ORDER_GAUSS_Interface.o obj/JAC2D_Interface.o obj/QSHEAR_Interface.o obj/QMEM1_Interface.o obj/outa_here_Interface.o obj/QPLT1_Interface.o obj/QPLT2_Interface.o obj/QPLT3_Interface.o obj/MATMULT_FFF_Interface.o obj/MATMULT_FFF_T_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/QMEM1_USE_IFs.o: USE_IFs/QMEM1_USE_IFs.f90 obj/OURTIM_Interface.o obj/ORDER_GAUSS_Interface.o obj/SHP2DQ_Interface.o obj/JAC2D_Interface.o obj/MATMULT_FFF_Interface.o obj/BMQMEM_Interface.o obj/MATMULT_FFF_T_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/QPLT1_USE_IFs.o: USE_IFs/QPLT1_USE_IFs.f90 obj/OURTIM_Interface.o obj/ORDER_GAUSS_Interface.o obj/SHP2DQ_Interface.o obj/JAC2D_Interface.o obj/MATMULT_FFF_Interface.o obj/BBDKQ_Interface.o obj/MATMULT_FFF_T_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/QPLT2_USE_IFs.o: USE_IFs/QPLT2_USE_IFs.f90 obj/OURTIM_Interface.o obj/ORDER_GAUSS_Interface.o obj/SHP2DQ_Interface.o obj/JAC2D_Interface.o obj/MATMULT_FFF_Interface.o obj/BBMIN4_Interface.o obj/MATMULT_FFF_T_Interface.o obj/MIN4SH_Interface.o obj/BSMIN4_Interface.o obj/CALC_PHI_SQ_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/QPLT3_USE_IFs.o: USE_IFs/QPLT3_USE_IFs.f90 obj/OURTIM_Interface.o obj/MATMULT_FFF_Interface.o obj/OUTA_HERE_Interface.o obj/TPLT2_Interface.o obj/MATMULT_FFF_T_Interface.o obj/MATADD_FFF_Interface.o obj/CHECK_MAT_INVERSE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/QSHEAR_USE_IFs.o: USE_IFs/QSHEAR_USE_IFs.f90 obj/OURTIM_Interface.o obj/ORDER_GAUSS_Interface.o obj/SHP2DQ_Interface.o obj/JAC2D_Interface.o obj/MATMULT_FFF_Interface.o obj/BMQMEM_Interface.o obj/MATMULT_FFF_T_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/R8FLD_USE_IFs.o: USE_IFs/R8FLD_USE_IFs.f90
	$(F77) $(FLAGS) -c $< -o $@
obj/RBE2_PROC_USE_IFs.o: USE_IFs/RBE2_PROC_USE_IFs.f90 obj/OURTIM_Interface.o obj/GET_GRID_NUM_COMPS_Interface.o obj/READERR_Interface.o obj/GET_ARRAY_ROW_NUM_Interface.o obj/GEN_T0L_Interface.o obj/MATMULT_FFF_T_Interface.o obj/MATMULT_FFF_Interface.o obj/TDOF_COL_NUM_Interface.o obj/RDOF_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/RBE3_PROC_USE_IFs.o: USE_IFs/RBE3_PROC_USE_IFs.f90 obj/OURTIM_Interface.o obj/GET_GRID_NUM_COMPS_Interface.o obj/READERR_Interface.o obj/GET_ARRAY_ROW_NUM_Interface.o obj/GEN_T0L_Interface.o obj/MATMULT_FFF_T_Interface.o obj/TDOF_COL_NUM_Interface.o obj/RDOF_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/RB_DISP_MATRIX_PROC_USE_IFs.o: USE_IFs/RB_DISP_MATRIX_PROC_USE_IFs.f90 obj/OURTIM_Interface.o obj/TDOF_COL_NUM_Interface.o obj/GET_ARRAY_ROW_NUM_Interface.o obj/OUTA_HERE_Interface.o obj/GET_GRID_NUM_COMPS_Interface.o obj/GEN_T0L_Interface.o obj/MATMULT_FFF_Interface.o obj/MATMULT_FFF_T_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/RDOF_USE_IFs.o: USE_IFs/RDOF_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/READERR_USE_IFs.o: USE_IFs/READERR_USE_IFs.f90 obj/OURTIM_Interface.o obj/WRITE_FILNAM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/READ_CHK_USE_IFs.o: USE_IFs/READ_CHK_USE_IFs.f90 obj/READERR_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/READ_CL_USE_IFs.o: USE_IFs/READ_CL_USE_IFs.f90 obj/GET_COMMAND_LINE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/READ_DOF_TABLES_USE_IFs.o: USE_IFs/READ_DOF_TABLES_USE_IFs.f90 obj/OURTIM_Interface.o obj/FILE_OPEN_Interface.o obj/READ_CHK_Interface.o obj/DATA_SET_NAME_ERROR_Interface.o obj/DATA_SET_SIZE_ERROR_Interface.o obj/FILE_CLOSE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/READ_IN4_FULL_MAT_USE_IFs.o: USE_IFs/READ_IN4_FULL_MAT_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/READ_INCLUDE_FILNAM_USE_IFs.o: USE_IFs/READ_INCLUDE_FILNAM_USE_IFs.f90 obj/OURTIM_Interface.o obj/CSHIFT_Interface.o obj/OPNERR_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/READ_INI_USE_IFs.o: USE_IFs/READ_INI_USE_IFs.f90 obj/GET_MYSTRAN_DIR_Interface.o obj/GET_INI_FILNAM_Interface.o obj/OPNERR_Interface.o obj/OUTA_HERE_Interface.o obj/MKJCARD_08_Interface.o obj/FILE_CLOSE_Interface.o obj/SET_FILE_CLOSE_STAT_Interface.o obj/WRITE_FILNAM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/READ_INPUT_FILE_NAME_USE_IFs.o: USE_IFs/READ_INPUT_FILE_NAME_USE_IFs.f90 obj/OUTA_HERE_Interface.o obj/READ_CL_Interface.o obj/WRITE_FILNAM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/READ_L1A_USE_IFs.o: USE_IFs/READ_L1A_USE_IFs.f90 obj/OURTIM_Interface.o obj/OPNERR_Interface.o obj/FILERR_Interface.o obj/OUTA_HERE_Interface.o obj/READERR_Interface.o obj/STMERR_Interface.o obj/FILE_CLOSE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/READ_L1M_USE_IFs.o: USE_IFs/READ_L1M_USE_IFs.f90 obj/FILE_OPEN_Interface.o obj/OURTIM_Interface.o obj/READERR_Interface.o obj/FILE_CLOSE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/READ_L1Z_USE_IFs.o: USE_IFs/READ_L1Z_USE_IFs.f90 obj/OURTIM_Interface.o obj/FILE_OPEN_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/READ_MATRIX_1_USE_IFs.o: USE_IFs/READ_MATRIX_1_USE_IFs.f90 obj/OURTIM_Interface.o obj/FILE_OPEN_Interface.o obj/READERR_Interface.o obj/OUTA_HERE_Interface.o obj/FILE_CLOSE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/READ_MATRIX_2_USE_IFs.o: USE_IFs/READ_MATRIX_2_USE_IFs.f90 obj/OURTIM_Interface.o obj/FILE_OPEN_Interface.o obj/READERR_Interface.o obj/OUTA_HERE_Interface.o obj/FILE_CLOSE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/READ_XTIME_USE_IFs.o: USE_IFs/READ_XTIME_USE_IFs.f90 obj/OURTIM_Interface.o obj/READERR_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/REAL_DATA_TO_C8FLD_USE_IFs.o: USE_IFs/REAL_DATA_TO_C8FLD_USE_IFs.f90
	$(F77) $(FLAGS) -c $< -o $@
obj/REDUCE_A_LR_USE_IFs.o: USE_IFs/REDUCE_A_LR_USE_IFs.f90 obj/OURTIM_Interface.o obj/PARTITION_VEC_Interface.o obj/REDUCE_KAA_TO_KLL_Interface.o obj/ALLOCATE_SPARSE_MAT_Interface.o obj/REDUCE_MAA_TO_MLL_Interface.o obj/REDUCE_PA_TO_PL_Interface.o obj/DEALLOCATE_SPARSE_MAT_Interface.o obj/WRITE_SPARSE_CRS_Interface.o obj/GET_MATRIX_DIAG_STATS_Interface.o obj/ALLOCATE_RBGLOBAL_Interface.o obj/TDOF_COL_NUM_Interface.o obj/STIFF_MAT_EQUIL_CHK_Interface.o obj/DEALLOCATE_RBGLOBAL_Interface.o obj/REDUCE_KAAD_TO_KLLD_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/REDUCE_F_AO_USE_IFs.o: USE_IFs/REDUCE_F_AO_USE_IFs.f90 obj/OURTIM_Interface.o obj/PARTITION_VEC_Interface.o obj/REDUCE_KFF_TO_KAA_Interface.o obj/REDUCE_MFF_TO_MAA_Interface.o obj/REDUCE_PF_TO_PA_Interface.o obj/ALLOCATE_SPARSE_MAT_Interface.o obj/DEALLOCATE_SPARSE_MAT_Interface.o obj/DEALLOCATE_LAPACK_MAT_Interface.o obj/WRITE_SPARSE_CRS_Interface.o obj/GET_MATRIX_DIAG_STATS_Interface.o obj/ALLOCATE_RBGLOBAL_Interface.o obj/TDOF_COL_NUM_Interface.o obj/STIFF_MAT_EQUIL_CHK_Interface.o obj/DEALLOCATE_RBGLOBAL_Interface.o obj/REDUCE_KFFD_TO_KAAD_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/REDUCE_G_NM_USE_IFs.o: USE_IFs/REDUCE_G_NM_USE_IFs.f90 obj/OURTIM_Interface.o obj/PARTITION_VEC_Interface.o obj/SOLVE_GMN_Interface.o obj/DEALLOCATE_SPARSE_MAT_Interface.o obj/REDUCE_KGG_TO_KNN_Interface.o obj/ALLOCATE_SPARSE_MAT_Interface.o obj/REDUCE_MGG_TO_MNN_Interface.o obj/REDUCE_PG_TO_PN_Interface.o obj/WRITE_SPARSE_CRS_Interface.o obj/GET_MATRIX_DIAG_STATS_Interface.o obj/ALLOCATE_RBGLOBAL_Interface.o obj/TDOF_COL_NUM_Interface.o obj/STIFF_MAT_EQUIL_CHK_Interface.o obj/GET_GRID_NUM_COMPS_Interface.o obj/AUTOSPC_SUMMARY_MSGS_Interface.o obj/REDUCE_KGGD_TO_KNND_Interface.o obj/OPNERR_Interface.o obj/FILERR_Interface.o obj/OUTA_HERE_Interface.o obj/GET_ARRAY_ROW_NUM_Interface.o obj/FILE_CLOSE_Interface.o obj/TDOF_PROC_Interface.o obj/FILE_OPEN_Interface.o obj/WRITE_DOF_TABLES_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/REDUCE_KAAD_TO_KLLD_USE_IFs.o: USE_IFs/REDUCE_KAAD_TO_KLLD_USE_IFs.f90 obj/OURTIM_Interface.o obj/PARTITION_SS_NTERM_Interface.o obj/ALLOCATE_SPARSE_MAT_Interface.o obj/PARTITION_SS_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/REDUCE_KAA_TO_KLL_USE_IFs.o: USE_IFs/REDUCE_KAA_TO_KLL_USE_IFs.f90 obj/OURTIM_Interface.o obj/PARTITION_SS_NTERM_Interface.o obj/ALLOCATE_SPARSE_MAT_Interface.o obj/PARTITION_SS_Interface.o obj/WRITE_MATRIX_1_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/REDUCE_KFFD_TO_KAAD_USE_IFs.o: USE_IFs/REDUCE_KFFD_TO_KAAD_USE_IFs.f90 obj/OURTIM_Interface.o obj/PARTITION_SS_NTERM_Interface.o obj/ALLOCATE_SPARSE_MAT_Interface.o obj/PARTITION_SS_Interface.o obj/ALLOCATE_SCR_CCS_MAT_Interface.o obj/SPARSE_CRS_SPARSE_CCS_Interface.o obj/MATMULT_SSS_NTERM_Interface.o obj/ALLOCATE_SCR_CRS_MAT_Interface.o obj/MATMULT_SSS_Interface.o obj/DEALLOCATE_SCR_MAT_Interface.o obj/SPARSE_CRS_TERM_COUNT_Interface.o obj/CRS_NONSYM_TO_CRS_SYM_Interface.o obj/OUTA_HERE_Interface.o obj/MATADD_SSS_NTERM_Interface.o obj/MATADD_SSS_Interface.o obj/DEALLOCATE_SPARSE_MAT_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/REDUCE_KFF_TO_KAA_USE_IFs.o: USE_IFs/REDUCE_KFF_TO_KAA_USE_IFs.f90 obj/OURTIM_Interface.o obj/PARTITION_SS_NTERM_Interface.o obj/ALLOCATE_SPARSE_MAT_Interface.o obj/PARTITION_SS_Interface.o obj/SYM_MAT_DECOMP_LAPACK_Interface.o obj/SOLVE_GOA_Interface.o obj/WRITE_MATRIX_1_Interface.o obj/ALLOCATE_SCR_CCS_MAT_Interface.o obj/SPARSE_CRS_SPARSE_CCS_Interface.o obj/MATMULT_SSS_NTERM_Interface.o obj/ALLOCATE_SCR_CRS_MAT_Interface.o obj/MATMULT_SSS_Interface.o obj/DEALLOCATE_SCR_MAT_Interface.o obj/SPARSE_CRS_TERM_COUNT_Interface.o obj/CRS_NONSYM_TO_CRS_SYM_Interface.o obj/OUTA_HERE_Interface.o obj/MATADD_SSS_NTERM_Interface.o obj/MATADD_SSS_Interface.o obj/DEALLOCATE_SPARSE_MAT_Interface.o obj/ALLOCATE_FULL_MAT_Interface.o obj/SPARSE_CRS_TO_FULL_Interface.o obj/MATMULT_FFF_Interface.o obj/DEALLOCATE_FULL_MAT_Interface.o obj/MATADD_FFF_Interface.o obj/CNT_NONZ_IN_FULL_MAT_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/REDUCE_KGGD_TO_KNND_USE_IFs.o: USE_IFs/REDUCE_KGGD_TO_KNND_USE_IFs.f90 obj/OURTIM_Interface.o obj/PARTITION_SS_NTERM_Interface.o obj/ALLOCATE_SPARSE_MAT_Interface.o obj/PARTITION_SS_Interface.o obj/MATTRNSP_SS_Interface.o obj/ALLOCATE_SCR_CCS_MAT_Interface.o obj/SPARSE_CRS_SPARSE_CCS_Interface.o obj/MATMULT_SSS_NTERM_Interface.o obj/ALLOCATE_SCR_CRS_MAT_Interface.o obj/MATMULT_SSS_Interface.o obj/MATADD_SSS_NTERM_Interface.o obj/MATADD_SSS_Interface.o obj/DEALLOCATE_SCR_MAT_Interface.o obj/SPARSE_CRS_TERM_COUNT_Interface.o obj/CRS_NONSYM_TO_CRS_SYM_Interface.o obj/OUTA_HERE_Interface.o obj/DEALLOCATE_SPARSE_MAT_Interface.o obj/WRITE_MATRIX_1_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/REDUCE_KGG_TO_KNN_USE_IFs.o: USE_IFs/REDUCE_KGG_TO_KNN_USE_IFs.f90 obj/OURTIM_Interface.o obj/PARTITION_SS_NTERM_Interface.o obj/ALLOCATE_SPARSE_MAT_Interface.o obj/PARTITION_SS_Interface.o obj/MATTRNSP_SS_Interface.o obj/ALLOCATE_SCR_CCS_MAT_Interface.o obj/SPARSE_CRS_SPARSE_CCS_Interface.o obj/MATMULT_SSS_NTERM_Interface.o obj/ALLOCATE_SCR_CRS_MAT_Interface.o obj/MATMULT_SSS_Interface.o obj/MATADD_SSS_NTERM_Interface.o obj/MATADD_SSS_Interface.o obj/DEALLOCATE_SCR_MAT_Interface.o obj/SPARSE_CRS_TERM_COUNT_Interface.o obj/CRS_NONSYM_TO_CRS_SYM_Interface.o obj/OUTA_HERE_Interface.o obj/DEALLOCATE_SPARSE_MAT_Interface.o obj/WRITE_MATRIX_1_Interface.o obj/ALLOCATE_FULL_MAT_Interface.o obj/SPARSE_CRS_TO_FULL_Interface.o obj/MATMULT_FFF_Interface.o obj/DEALLOCATE_FULL_MAT_Interface.o obj/MATADD_FFF_Interface.o obj/MATMULT_FFF_T_Interface.o obj/CNT_NONZ_IN_FULL_MAT_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/REDUCE_KNND_TO_KFFD_USE_IFs.o: USE_IFs/REDUCE_KNND_TO_KFFD_USE_IFs.f90 obj/OURTIM_Interface.o obj/PARTITION_SS_NTERM_Interface.o obj/ALLOCATE_SPARSE_MAT_Interface.o obj/PARTITION_SS_Interface.o obj/MATTRNSP_SS_Interface.o obj/WRITE_MATRIX_1_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/REDUCE_KNN_TO_KFF_USE_IFs.o: USE_IFs/REDUCE_KNN_TO_KFF_USE_IFs.f90 obj/OURTIM_Interface.o obj/PARTITION_SS_NTERM_Interface.o obj/ALLOCATE_SPARSE_MAT_Interface.o obj/PARTITION_SS_Interface.o obj/MATTRNSP_SS_Interface.o obj/WRITE_MATRIX_1_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/REDUCE_MAA_TO_MLL_USE_IFs.o: USE_IFs/REDUCE_MAA_TO_MLL_USE_IFs.f90 obj/OURTIM_Interface.o obj/PARTITION_SS_NTERM_Interface.o obj/ALLOCATE_SPARSE_MAT_Interface.o obj/PARTITION_SS_Interface.o obj/WRITE_MATRIX_1_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/REDUCE_MFF_TO_MAA_USE_IFs.o: USE_IFs/REDUCE_MFF_TO_MAA_USE_IFs.f90 obj/OURTIM_Interface.o obj/PARTITION_SS_NTERM_Interface.o obj/ALLOCATE_SPARSE_MAT_Interface.o obj/PARTITION_SS_Interface.o obj/MATTRNSP_SS_Interface.o obj/ALLOCATE_SCR_CCS_MAT_Interface.o obj/SPARSE_CRS_SPARSE_CCS_Interface.o obj/MATMULT_SSS_NTERM_Interface.o obj/ALLOCATE_SCR_CRS_MAT_Interface.o obj/MATMULT_SSS_Interface.o obj/MATADD_SSS_NTERM_Interface.o obj/MATADD_SSS_Interface.o obj/DEALLOCATE_SCR_MAT_Interface.o obj/SPARSE_CRS_TERM_COUNT_Interface.o obj/CRS_NONSYM_TO_CRS_SYM_Interface.o obj/OUTA_HERE_Interface.o obj/DEALLOCATE_SPARSE_MAT_Interface.o obj/ALLOCATE_FULL_MAT_Interface.o obj/SPARSE_CRS_TO_FULL_Interface.o obj/MATMULT_FFF_Interface.o obj/DEALLOCATE_FULL_MAT_Interface.o obj/MATADD_FFF_Interface.o obj/MATMULT_FFF_T_Interface.o obj/CNT_NONZ_IN_FULL_MAT_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/REDUCE_MGG_TO_MNN_USE_IFs.o: USE_IFs/REDUCE_MGG_TO_MNN_USE_IFs.f90 obj/OURTIM_Interface.o obj/PARTITION_SS_NTERM_Interface.o obj/ALLOCATE_SPARSE_MAT_Interface.o obj/PARTITION_SS_Interface.o obj/MATTRNSP_SS_Interface.o obj/ALLOCATE_SCR_CCS_MAT_Interface.o obj/SPARSE_CRS_SPARSE_CCS_Interface.o obj/MATMULT_SSS_NTERM_Interface.o obj/ALLOCATE_SCR_CRS_MAT_Interface.o obj/MATMULT_SSS_Interface.o obj/MATADD_SSS_NTERM_Interface.o obj/MATADD_SSS_Interface.o obj/DEALLOCATE_SCR_MAT_Interface.o obj/SPARSE_CRS_TERM_COUNT_Interface.o obj/CRS_NONSYM_TO_CRS_SYM_Interface.o obj/OUTA_HERE_Interface.o obj/DEALLOCATE_SPARSE_MAT_Interface.o obj/WRITE_MATRIX_1_Interface.o obj/ALLOCATE_FULL_MAT_Interface.o obj/SPARSE_CRS_TO_FULL_Interface.o obj/MATMULT_FFF_Interface.o obj/DEALLOCATE_FULL_MAT_Interface.o obj/MATADD_FFF_Interface.o obj/MATMULT_FFF_T_Interface.o obj/CNT_NONZ_IN_FULL_MAT_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/REDUCE_MNN_TO_MFF_USE_IFs.o: USE_IFs/REDUCE_MNN_TO_MFF_USE_IFs.f90 obj/OURTIM_Interface.o obj/PARTITION_SS_NTERM_Interface.o obj/ALLOCATE_SPARSE_MAT_Interface.o obj/PARTITION_SS_Interface.o obj/MATTRNSP_SS_Interface.o obj/WRITE_MATRIX_1_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/REDUCE_N_FS_USE_IFs.o: USE_IFs/REDUCE_N_FS_USE_IFs.f90 obj/OURTIM_Interface.o obj/PARTITION_VEC_Interface.o obj/ALLOCATE_COL_VEC_Interface.o obj/FILE_OPEN_Interface.o obj/READERR_Interface.o obj/OUTA_HERE_Interface.o obj/FILE_CLOSE_Interface.o obj/WRITE_VECTOR_Interface.o obj/REDUCE_KNN_TO_KFF_Interface.o obj/ALLOCATE_SPARSE_MAT_Interface.o obj/REDUCE_MNN_TO_MFF_Interface.o obj/REDUCE_PN_TO_PF_Interface.o obj/DEALLOCATE_SPARSE_MAT_Interface.o obj/MATMULT_SFS_NTERM_Interface.o obj/WRITE_SPARSE_CRS_Interface.o obj/MATMULT_SFS_Interface.o obj/WRITE_MATRIX_1_Interface.o obj/DEALLOCATE_COL_VEC_Interface.o obj/GET_MATRIX_DIAG_STATS_Interface.o obj/ALLOCATE_RBGLOBAL_Interface.o obj/TDOF_COL_NUM_Interface.o obj/STIFF_MAT_EQUIL_CHK_Interface.o obj/DEALLOCATE_RBGLOBAL_Interface.o obj/REDUCE_KNND_TO_KFFD_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/REDUCE_PA_TO_PL_USE_IFs.o: USE_IFs/REDUCE_PA_TO_PL_USE_IFs.f90 obj/OURTIM_Interface.o obj/PARTITION_SS_NTERM_Interface.o obj/ALLOCATE_SPARSE_MAT_Interface.o obj/PARTITION_SS_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/REDUCE_PF_TO_PA_USE_IFs.o: USE_IFs/REDUCE_PF_TO_PA_USE_IFs.f90 obj/OURTIM_Interface.o obj/PARTITION_SS_NTERM_Interface.o obj/ALLOCATE_SPARSE_MAT_Interface.o obj/PARTITION_SS_Interface.o obj/MATTRNSP_SS_Interface.o obj/ALLOCATE_SCR_CCS_MAT_Interface.o obj/SPARSE_CRS_SPARSE_CCS_Interface.o obj/MATMULT_SSS_NTERM_Interface.o obj/ALLOCATE_SCR_CRS_MAT_Interface.o obj/MATMULT_SSS_Interface.o obj/DEALLOCATE_SCR_MAT_Interface.o obj/MATADD_SSS_NTERM_Interface.o obj/MATADD_SSS_Interface.o obj/DEALLOCATE_SPARSE_MAT_Interface.o obj/ALLOCATE_FULL_MAT_Interface.o obj/SPARSE_CRS_TO_FULL_Interface.o obj/MATMULT_FFF_T_Interface.o obj/DEALLOCATE_FULL_MAT_Interface.o obj/MATADD_FFF_Interface.o obj/CNT_NONZ_IN_FULL_MAT_Interface.o obj/OUTA_HERE_Interface.o obj/SOLVE_UO0_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/REDUCE_PG_TO_PN_USE_IFs.o: USE_IFs/REDUCE_PG_TO_PN_USE_IFs.f90 obj/OURTIM_Interface.o obj/PARTITION_SS_NTERM_Interface.o obj/ALLOCATE_SPARSE_MAT_Interface.o obj/PARTITION_SS_Interface.o obj/MATTRNSP_SS_Interface.o obj/ALLOCATE_SCR_CCS_MAT_Interface.o obj/SPARSE_CRS_SPARSE_CCS_Interface.o obj/MATMULT_SSS_NTERM_Interface.o obj/ALLOCATE_SCR_CRS_MAT_Interface.o obj/MATMULT_SSS_Interface.o obj/DEALLOCATE_SCR_MAT_Interface.o obj/MATADD_SSS_NTERM_Interface.o obj/MATADD_SSS_Interface.o obj/DEALLOCATE_SPARSE_MAT_Interface.o obj/ALLOCATE_FULL_MAT_Interface.o obj/SPARSE_CRS_TO_FULL_Interface.o obj/MATMULT_FFF_T_Interface.o obj/DEALLOCATE_FULL_MAT_Interface.o obj/MATADD_FFF_Interface.o obj/CNT_NONZ_IN_FULL_MAT_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/REDUCE_PN_TO_PF_USE_IFs.o: USE_IFs/REDUCE_PN_TO_PF_USE_IFs.f90 obj/OURTIM_Interface.o obj/PARTITION_SS_NTERM_Interface.o obj/ALLOCATE_SPARSE_MAT_Interface.o obj/PARTITION_SS_Interface.o obj/DEALLOCATE_SPARSE_MAT_Interface.o obj/MATMULT_SFS_NTERM_Interface.o obj/MATMULT_SFS_Interface.o obj/MATADD_SSS_NTERM_Interface.o obj/MATADD_SSS_Interface.o obj/WRITE_SPARSE_CRS_Interface.o obj/ALLOCATE_FULL_MAT_Interface.o obj/SPARSE_CRS_TO_FULL_Interface.o obj/MATMULT_FFF_Interface.o obj/DEALLOCATE_FULL_MAT_Interface.o obj/MATADD_FFF_Interface.o obj/OUTA_HERE_Interface.o obj/WRITE_MATRIX_1_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/RENORM_ON_MASS_USE_IFs.o: USE_IFs/RENORM_ON_MASS_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/RENORM_USE_IFs.o: USE_IFs/RENORM_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/REPLACE_TABS_W_BLANKS_USE_IFs.o: USE_IFs/REPLACE_TABS_W_BLANKS_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/RESTART_DATA_FOR_L3_USE_IFs.o: USE_IFs/RESTART_DATA_FOR_L3_USE_IFs.f90 obj/OURTIM_Interface.o obj/ALLOCATE_SPARSE_MAT_Interface.o obj/READ_MATRIX_1_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/RFORCE_PROC_USE_IFs.o: USE_IFs/RFORCE_PROC_USE_IFs.f90 obj/OURTIM_Interface.o obj/OPNERR_Interface.o obj/FILE_CLOSE_Interface.o obj/OUTA_HERE_Interface.o obj/READERR_Interface.o obj/GET_ARRAY_ROW_NUM_Interface.o obj/MATMULT_FFF_Interface.o obj/GEN_T0L_Interface.o obj/MATMULT_FFF_T_Interface.o obj/GET_GRID_6X6_MASS_Interface.o obj/TDOF_COL_NUM_Interface.o obj/CROSS_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/RIGID_BODY_DISP_MAT_USE_IFs.o: USE_IFs/RIGID_BODY_DISP_MAT_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/RIGID_ELEM_PROC_USE_IFs.o: USE_IFs/RIGID_ELEM_PROC_USE_IFs.f90 obj/OURTIM_Interface.o obj/READERR_Interface.o obj/OUTA_HERE_Interface.o obj/RBE2_PROC_Interface.o obj/RBE3_PROC_Interface.o obj/RSPLINE_PROC_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ROD1_USE_IFs.o: USE_IFs/ROD1_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ROD_MARGIN_USE_IFs.o: USE_IFs/ROD_MARGIN_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ROT_AXES_MATL_TO_LOC_USE_IFs.o: USE_IFs/ROT_AXES_MATL_TO_LOC_USE_IFs.f90 obj/OURTIM_Interface.o obj/PLANE_COORD_TRANS_21_Interface.o obj/MATMULT_FFF_Interface.o obj/MATMULT_FFF_T_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ROT_COMP_ELEM_AXES_USE_IFs.o: USE_IFs/ROT_COMP_ELEM_AXES_USE_IFs.f90 obj/OURTIM_Interface.o obj/MATMULT_FFF_Interface.o obj/MATMULT_FFF_T_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ROW_AT_COLJ_BEGEND_USE_IFs.o: USE_IFs/ROW_AT_COLJ_BEGEND_USE_IFs.f90 obj/OURTIM_Interface.o obj/ARRAY_SIZE_ERROR_1_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/RSPLINE_PROC_USE_IFs.o: USE_IFs/RSPLINE_PROC_USE_IFs.f90 obj/OURTIM_Interface.o obj/GET_GRID_NUM_COMPS_Interface.o obj/READERR_Interface.o obj/GET_ARRAY_ROW_NUM_Interface.o obj/GEN_T0L_Interface.o obj/TDOF_COL_NUM_Interface.o obj/RDOF_Interface.o obj/OUTA_HERE_Interface.o obj/CALC_VEC_SORT_ORDER_Interface.o obj/CROSS_Interface.o obj/MATMULT_FFF_Interface.o obj/MATMULT_FFF_T_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/RW_INCLUDE_FILES_USE_IFs.o: USE_IFs/RW_INCLUDE_FILES_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SEQ_PROC_USE_IFs.o: USE_IFs/SEQ_PROC_USE_IFs.f90 obj/OURTIM_Interface.o obj/GET_ARRAY_ROW_NUM_Interface.o obj/OUTA_HERE_Interface.o obj/SORT_INT1_REAL1_Interface.o obj/SORT_REAL1_INT1_Interface.o obj/SORT_INT2_REAL1_Interface.o obj/SORT_INT2_Interface.o obj/OPNERR_Interface.o obj/READERR_Interface.o obj/STMERR_Interface.o obj/DEALLOCATE_MODEL_STUF_Interface.o obj/ALLOCATE_MODEL_STUF_Interface.o obj/MKJCARD_Interface.o obj/LEFT_ADJ_BDFLD_Interface.o obj/MKCARD_Interface.o obj/BD_SEQGP_Interface.o obj/SORT_INT1_Interface.o obj/WRITE_INTEGER_VEC_Interface.o obj/FILE_CLOSE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SET_FILE_CLOSE_STAT_USE_IFs.o: USE_IFs/SET_FILE_CLOSE_STAT_USE_IFs.f90
	$(F77) $(FLAGS) -c $< -o $@
obj/SET_SPARSE_MAT_SYM_USE_IFs.o: USE_IFs/SET_SPARSE_MAT_SYM_USE_IFs.f90
	$(F77) $(FLAGS) -c $< -o $@
obj/SHELL_ABD_MATRICES_USE_IFs.o: USE_IFs/SHELL_ABD_MATRICES_USE_IFs.f90 obj/OURTIM_Interface.o obj/IS_ELEM_PCOMP_PROPS_Interface.o obj/MATMULT_FFF_Interface.o obj/GET_ELEM_NUM_PLIES_Interface.o obj/MATERIAL_PROPS_2D_Interface.o obj/ROT_COMP_ELEM_AXES_Interface.o obj/WRITE_PCOMP_EQUIV_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SHELL_ENGR_FORCE_OGEL_USE_IFs.o: USE_IFs/SHELL_ENGR_FORCE_OGEL_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SHELL_STRAIN_OUTPUTS_USE_IFs.o: USE_IFs/SHELL_STRAIN_OUTPUTS_USE_IFs.f90 obj/OURTIM_Interface.o obj/PRINCIPAL_2D_Interface.o obj/OUTA_HERE_Interface.o obj/GET_COMP_SHELL_ALLOWS_Interface.o obj/POLY_FAILURE_INDEX_Interface.o obj/INDEP_FAILURE_INDEX_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SHELL_STRESS_OUTPUTS_USE_IFs.o: USE_IFs/SHELL_STRESS_OUTPUTS_USE_IFs.f90 obj/OURTIM_Interface.o obj/PRINCIPAL_2D_Interface.o obj/OUTA_HERE_Interface.o obj/GET_COMP_SHELL_ALLOWS_Interface.o obj/POLY_FAILURE_INDEX_Interface.o obj/INDEP_FAILURE_INDEX_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SHP2DQ_USE_IFs.o: USE_IFs/SHP2DQ_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SHP3DH_USE_IFs.o: USE_IFs/SHP3DH_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SHP3DP_USE_IFs.o: USE_IFs/SHP3DP_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SHP3DT_USE_IFs.o: USE_IFs/SHP3DT_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SLOAD_PROC_USE_IFs.o: USE_IFs/SLOAD_PROC_USE_IFs.f90 obj/OURTIM_Interface.o obj/READERR_Interface.o obj/FILE_CLOSE_Interface.o obj/OUTA_HERE_Interface.o obj/GET_ARRAY_ROW_NUM_Interface.o obj/TDOF_COL_NUM_Interface.o obj/FILERR_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SOLID_STRAIN_OUTPUTS_USE_IFs.o: USE_IFs/SOLID_STRAIN_OUTPUTS_USE_IFs.f90 obj/OURTIM_Interface.o obj/PRINCIPAL_3D_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SOLID_STRESS_OUTPUTS_USE_IFs.o: USE_IFs/SOLID_STRESS_OUTPUTS_USE_IFs.f90 obj/OURTIM_Interface.o obj/PRINCIPAL_3D_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SOLVE6_SETUP_USE_IFs.o: USE_IFs/SOLVE6_SETUP_USE_IFs.f90 obj/OURTIM_Interface.o obj/SYM_MAT_DECOMP_LAPACK_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SOLVE_DLR_USE_IFs.o: USE_IFs/SOLVE_DLR_USE_IFs.f90 obj/OURTIM_Interface.o obj/SYM_MAT_DECOMP_LAPACK_Interface.o obj/OUTA_HERE_Interface.o obj/OPNERR_Interface.o obj/FILE_CLOSE_Interface.o obj/GET_SPARSE_CRS_ROW_Interface.o obj/FBS_LAPACK_Interface.o obj/deallocate_sparse_mat_Interface.o obj/ALLOCATE_SPARSE_MAT_Interface.o obj/ALLOCATE_L6_2_Interface.o obj/READ_MATRIX_2_Interface.o obj/GET_I_MAT_FROM_I2_MAT_Interface.o obj/MATTRNSP_SS_Interface.o obj/WRITE_SPARSE_CRS_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SOLVE_GMN_USE_IFs.o: USE_IFs/SOLVE_GMN_USE_IFs.f90 obj/OURTIM_Interface.o obj/WRITE_SPARSE_CRS_Interface.o obj/PARTITION_SS_NTERM_Interface.o obj/ALLOCATE_SPARSE_MAT_Interface.o obj/PARTITION_SS_Interface.o obj/OUTA_HERE_Interface.o obj/ALLOCATE_L2_GMN_2_Interface.o obj/WRITE_MATRIX_1_Interface.o obj/DEALLOCATE_SPARSE_MAT_Interface.o obj/DEALLOCATE_L2_GMN_2_Interface.o obj/ALLOCATE_FULL_MAT_Interface.o obj/SPARSE_CRS_TO_FULL_Interface.o obj/GET_GRID_AND_COMP_Interface.o obj/OPNERR_Interface.o obj/FILE_CLOSE_Interface.o obj/GET_SPARSE_CRS_COL_Interface.o obj/DEALLOCATE_FULL_MAT_Interface.o obj/READ_MATRIX_2_Interface.o obj/SORT_INT2_REAL1_Interface.o obj/READ_MATRIX_1_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SOLVE_GOA_USE_IFs.o: USE_IFs/SOLVE_GOA_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o obj/OPNERR_Interface.o obj/FILE_CLOSE_Interface.o obj/GET_SPARSE_CRS_ROW_Interface.o obj/FBS_LAPACK_Interface.o obj/ALLOCATE_SPARSE_MAT_Interface.o obj/ALLOCATE_L2_GOA_2_Interface.o obj/READ_MATRIX_2_Interface.o obj/SORT_INT2_REAL1_Interface.o obj/DEALLOCATE_SPARSE_MAT_Interface.o obj/DEALLOCATE_L2_GOA_2_Interface.o obj/READ_MATRIX_1_Interface.o obj/WRITE_SPARSE_CRS_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SOLVE_PHIZL1_USE_IFs.o: USE_IFs/SOLVE_PHIZL1_USE_IFs.f90 obj/OURTIM_Interface.o obj/SYM_MAT_DECOMP_LAPACK_Interface.o obj/OUTA_HERE_Interface.o obj/OPNERR_Interface.o obj/FILE_CLOSE_Interface.o obj/GET_SPARSE_CRS_COL_Interface.o obj/FBS_LAPACK_Interface.o obj/deallocate_sparse_mat_Interface.o obj/ALLOCATE_SPARSE_MAT_Interface.o obj/ALLOCATE_L6_2_Interface.o obj/READ_MATRIX_2_Interface.o obj/GET_I_MAT_FROM_I2_MAT_Interface.o obj/MATTRNSP_SS_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SOLVE_SHELL_ALP_USE_IFs.o: USE_IFs/SOLVE_SHELL_ALP_USE_IFs.f90 obj/INVERT_FF_MAT_Interface.o obj/MATMULT_FFF_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SOLVE_UO0_USE_IFs.o: USE_IFs/SOLVE_UO0_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o obj/FILE_OPEN_Interface.o obj/ALLOCATE_COL_VEC_Interface.o obj/GET_SPARSE_CRS_COL_Interface.o obj/FBS_LAPACK_Interface.o obj/WRITE_VECTOR_Interface.o obj/DEALLOCATE_COL_VEC_Interface.o obj/FILE_CLOSE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SORTLEN_USE_IFs.o: USE_IFs/SORTLEN_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SORT_GRID_RGRID_USE_IFs.o: USE_IFs/SORT_GRID_RGRID_USE_IFs.f90 obj/OURTIM_Interface.o obj/SORTLEN_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SORT_INT1_REAL1_USE_IFs.o: USE_IFs/SORT_INT1_REAL1_USE_IFs.f90 obj/OURTIM_Interface.o obj/SORTLEN_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SORT_INT1_REAL3_USE_IFs.o: USE_IFs/SORT_INT1_REAL3_USE_IFs.f90 obj/OURTIM_Interface.o obj/SORTLEN_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SORT_INT1_USE_IFs.o: USE_IFs/SORT_INT1_USE_IFs.f90 obj/OURTIM_Interface.o obj/SORTLEN_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SORT_INT2_REAL1_USE_IFs.o: USE_IFs/SORT_INT2_REAL1_USE_IFs.f90 obj/OURTIM_Interface.o obj/SORTLEN_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SORT_INT2_USE_IFs.o: USE_IFs/SORT_INT2_USE_IFs.f90 obj/OURTIM_Interface.o obj/SORTLEN_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SORT_INT3_CHAR2_USE_IFs.o: USE_IFs/SORT_INT3_CHAR2_USE_IFs.f90 obj/OURTIM_Interface.o obj/SORTLEN_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SORT_INT3_USE_IFs.o: USE_IFs/SORT_INT3_USE_IFs.f90 obj/OURTIM_Interface.o obj/SORTLEN_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SORT_REAL1_INT1_USE_IFs.o: USE_IFs/SORT_REAL1_INT1_USE_IFs.f90 obj/OURTIM_Interface.o obj/SORTLEN_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SORT_TDOF_USE_IFs.o: USE_IFs/SORT_TDOF_USE_IFs.f90 obj/OURTIM_Interface.o obj/SORTLEN_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SPARSE_CRS_SPARSE_CCS_USE_IFs.o: USE_IFs/SPARSE_CRS_SPARSE_CCS_USE_IFs.f90 obj/OURTIM_Interface.o obj/ARRAY_SIZE_ERROR_1_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SPARSE_CRS_TERM_COUNT_USE_IFs.o: USE_IFs/SPARSE_CRS_TERM_COUNT_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SPARSE_CRS_TO_FULL_USE_IFs.o: USE_IFs/SPARSE_CRS_TO_FULL_USE_IFs.f90 obj/OURTIM_Interface.o obj/ARRAY_SIZE_ERROR_1_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SPARSE_KGGD_USE_IFs.o: USE_IFs/SPARSE_KGGD_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o obj/ALLOCATE_SPARSE_MAT_Interface.o obj/TDOF_COL_NUM_Interface.o obj/GET_ARRAY_ROW_NUM_Interface.o obj/GET_GRID_NUM_COMPS_Interface.o obj/SORT_INT1_REAL1_Interface.o obj/WRITE_SPARSE_CRS_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SPARSE_KGG_USE_IFs.o: USE_IFs/SPARSE_KGG_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o obj/ALLOCATE_SPARSE_MAT_Interface.o obj/FILE_OPEN_Interface.o obj/OPNERR_Interface.o obj/FILERR_Interface.o obj/TDOF_COL_NUM_Interface.o obj/GET_ARRAY_ROW_NUM_Interface.o obj/GET_GRID_NUM_COMPS_Interface.o obj/SORT_INT1_REAL1_Interface.o obj/KGG_SINGULARITY_PROC_Interface.o obj/WRITE_SPARSE_CRS_Interface.o obj/AUTOSPC_SUMMARY_MSGS_Interface.o obj/TDOF_PROC_Interface.o obj/FILE_CLOSE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SPARSE_MAT_DIAG_ZEROS_USE_IFs.o: USE_IFs/SPARSE_MAT_DIAG_ZEROS_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SPARSE_MGG_USE_IFs.o: USE_IFs/SPARSE_MGG_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o obj/FILE_OPEN_Interface.o obj/GET_ARRAY_ROW_NUM_Interface.o obj/GET_GRID_NUM_COMPS_Interface.o obj/SORT_INT1_REAL1_Interface.o obj/ARRAY_SIZE_ERROR_1_Interface.o obj/MGGS_MASS_MATRIX_Interface.o obj/MATADD_SSS_NTERM_Interface.o obj/ALLOCATE_SCR_CRS_MAT_Interface.o obj/MATADD_SSS_Interface.o obj/ALLOCATE_L1_MGG_Interface.o obj/ALLOCATE_SPARSE_MAT_Interface.o obj/DEALLOCATE_SCR_MAT_Interface.o obj/WRITE_SPARSE_CRS_Interface.o obj/FILE_CLOSE_Interface.o obj/GET_GRID_6X6_MASS_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SPARSE_PG_USE_IFs.o: USE_IFs/SPARSE_PG_USE_IFs.f90 obj/OURTIM_Interface.o obj/FILE_OPEN_Interface.o obj/ALLOCATE_SPARSE_MAT_Interface.o obj/OUTA_HERE_Interface.o obj/FILE_CLOSE_Interface.o obj/WRITE_SPARSE_CRS_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SPARSE_RMG_USE_IFs.o: USE_IFs/SPARSE_RMG_USE_IFs.f90 obj/OURTIM_Interface.o obj/FILE_OPEN_Interface.o obj/READERR_Interface.o obj/OUTA_HERE_Interface.o obj/FILE_CLOSE_Interface.o obj/ALLOCATE_SPARSE_MAT_Interface.o obj/ARRAY_SIZE_ERROR_1_Interface.o obj/SORT_INT2_REAL1_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/STIFF_MAT_EQUIL_CHK_USE_IFs.o: USE_IFs/STIFF_MAT_EQUIL_CHK_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o obj/MATMULT_SFF_Interface.o obj/BANDSIZ_Interface.o obj/ALLOCATE_LAPACK_MAT_Interface.o obj/BANDGEN_LAPACK_DPB_Interface.o obj/WRITE_MATRIX_BY_ROWS_Interface.o obj/DEALLOCATE_LAPACK_MAT_Interface.o obj/TDOF_COL_NUM_Interface.o obj/MATMULT_FFF_T_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/STMERR_USE_IFs.o: USE_IFs/STMERR_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/STOKEN_USE_IFs.o: USE_IFs/STOKEN_USE_IFs.f90 obj/OURTIM_Interface.o obj/TOKCHK_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/STR_TENSOR_TRANSFORM_USE_IFs.o: USE_IFs/STR_TENSOR_TRANSFORM_USE_IFs.f90 obj/OURTIM_Interface.o obj/MATMULT_FFF_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SUBCASE_PROC_USE_IFs.o: USE_IFs/SUBCASE_PROC_USE_IFs.f90 obj/OURTIM_Interface.o obj/STOKEN_Interface.o obj/GET_ARRAY_ROW_NUM_Interface.o obj/OUTA_HERE_Interface.o obj/TOKCHK_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SURFACE_FIT_USE_IFs.o: USE_IFs/SURFACE_FIT_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SUSER1_USE_IFs.o: USE_IFs/SUSER1_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SYM_MAT_DECOMP_LAPACK_USE_IFs.o: USE_IFs/SYM_MAT_DECOMP_LAPACK_USE_IFs.f90 obj/OURTIM_Interface.o obj/DEALLOCATE_LAPACK_MAT_Interface.o obj/BANDSIZ_Interface.o obj/ALLOCATE_LAPACK_MAT_Interface.o obj/BANDGEN_LAPACK_DPB_Interface.o obj/WRITE_MATRIX_BY_ROWS_Interface.o obj/OUTA_HERE_Interface.o obj/GET_GRID_AND_COMP_Interface.o obj/COND_NUM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/TDOF_COL_NUM_USE_IFs.o: USE_IFs/TDOF_COL_NUM_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/TDOF_PROC_USE_IFs.o: USE_IFs/TDOF_PROC_USE_IFs.f90 obj/OURTIM_Interface.o obj/CALC_TDOF_ROW_START_Interface.o obj/TDOF_COL_NUM_Interface.o obj/GET_GRID_NUM_COMPS_Interface.o obj/ARRAY_SIZE_ERROR_1_Interface.o obj/OUTA_HERE_Interface.o obj/SORT_TDOF_Interface.o obj/WRITE_TDOF_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/TEMPERATURE_DATA_PROC_USE_IFs.o: USE_IFs/TEMPERATURE_DATA_PROC_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o obj/FILE_CLOSE_Interface.o obj/FILE_OPEN_Interface.o obj/READERR_Interface.o obj/MKJCARD_Interface.o obj/GET_ARRAY_ROW_NUM_Interface.o obj/TOKCHK_Interface.o obj/GET_ELGP_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/TETRA_USE_IFs.o: USE_IFs/TETRA_USE_IFs.f90 obj/OURTIM_Interface.o obj/ORDER_TETRA_Interface.o obj/SHP3DT_Interface.o obj/JAC3D_Interface.o obj/MATMULT_FFF_Interface.o obj/B3D_ISOPARAMETRIC_Interface.o obj/MATMULT_FFF_T_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/TIME_INIT_USE_IFs.o: USE_IFs/TIME_INIT_USE_IFs.f90
	$(F77) $(FLAGS) -c $< -o $@
obj/TMEM1_USE_IFs.o: USE_IFs/TMEM1_USE_IFs.f90 obj/OURTIM_Interface.o obj/MATMULT_FFF_T_Interface.o obj/MATMULT_FFF_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/TOKCHK_USE_IFs.o: USE_IFs/TOKCHK_USE_IFs.f90
	$(F77) $(FLAGS) -c $< -o $@
obj/TPLT1_USE_IFs.o: USE_IFs/TPLT1_USE_IFs.f90 obj/OURTIM_Interface.o obj/MATMULT_FFF_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/TPLT2_USE_IFs.o: USE_IFs/TPLT2_USE_IFs.f90 obj/OURTIM_Interface.o obj/BBMIN3_Interface.o obj/MATMULT_FFF_T_Interface.o obj/MATMULT_FFF_Interface.o obj/CALC_PHI_SQ_Interface.o obj/BSMIN3_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/TRANSFORM_NODE_FORCES_USE_IFs.o: USE_IFs/TRANSFORM_NODE_FORCES_USE_IFs.f90 obj/OURTIM_Interface.o obj/GEN_T0L_Interface.o obj/MATGET_Interface.o obj/MATMULT_FFF_T_Interface.o obj/MATPUT_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/TREL1_USE_IFs.o: USE_IFs/TREL1_USE_IFs.f90 obj/OURTIM_Interface.o obj/TMEM1_Interface.o obj/TPLT1_Interface.o obj/TPLT2_Interface.o obj/outa_here_Interface.o obj/MATMULT_FFF_Interface.o obj/MATMULT_FFF_T_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/TSET_PROC_FOR_MPCS_USE_IFs.o: USE_IFs/TSET_PROC_FOR_MPCS_USE_IFs.f90 obj/OURTIM_Interface.o obj/READERR_Interface.o obj/OUTA_HERE_Interface.o obj/GET_ARRAY_ROW_NUM_Interface.o obj/ARRAY_SIZE_ERROR_1_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/TSET_PROC_FOR_OMITS_USE_IFs.o: USE_IFs/TSET_PROC_FOR_OMITS_USE_IFs.f90 obj/OURTIM_Interface.o obj/READERR_Interface.o obj/OUTA_HERE_Interface.o obj/RDOF_Interface.o obj/GET_ARRAY_ROW_NUM_Interface.o obj/GET_GRID_NUM_COMPS_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/TSET_PROC_FOR_RIGELS_USE_IFs.o: USE_IFs/TSET_PROC_FOR_RIGELS_USE_IFs.f90 obj/OURTIM_Interface.o obj/READERR_Interface.o obj/OUTA_HERE_Interface.o obj/GET_ARRAY_ROW_NUM_Interface.o obj/RDOF_Interface.o obj/ARRAY_SIZE_ERROR_1_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/TSET_PROC_FOR_SPCS_USE_IFs.o: USE_IFs/TSET_PROC_FOR_SPCS_USE_IFs.f90 obj/OURTIM_Interface.o obj/RDOF_Interface.o obj/GET_GRID_NUM_COMPS_Interface.o obj/ALLOCATE_MODEL_STUF_Interface.o obj/READERR_Interface.o obj/OUTA_HERE_Interface.o obj/GET_ARRAY_ROW_NUM_Interface.o obj/DEALLOCATE_MODEL_STUF_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/TSET_PROC_FOR_SUPORTS_USE_IFs.o: USE_IFs/TSET_PROC_FOR_SUPORTS_USE_IFs.f90 obj/OURTIM_Interface.o obj/READERR_Interface.o obj/OUTA_HERE_Interface.o obj/GET_ARRAY_ROW_NUM_Interface.o obj/RDOF_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/TSET_PROC_USE_IFs.o: USE_IFs/TSET_PROC_USE_IFs.f90 obj/OURTIM_Interface.o obj/GET_GRID_NUM_COMPS_Interface.o obj/TSET_PROC_FOR_MPCS_Interface.o obj/TSET_PROC_FOR_RIGELS_Interface.o obj/TSET_PROC_FOR_SPCS_Interface.o obj/TSET_PROC_FOR_OMITS_Interface.o obj/OUTA_HERE_Interface.o obj/TSET_PROC_FOR_SUPORTS_Interface.o obj/WRITE_TSET_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/USERIN_USE_IFs.o: USE_IFs/USERIN_USE_IFs.f90 obj/OURTIM_Interface.o obj/RB_DISP_MATRIX_PROC_Interface.o obj/TDOF_COL_NUM_Interface.o obj/GET_ARRAY_ROW_NUM_Interface.o obj/RDOF_Interface.o obj/ALLOCATE_IN4_FILES_Interface.o obj/FILE_OPEN_Interface.o obj/READ_IN4_FULL_MAT_Interface.o obj/OUTA_HERE_Interface.o obj/MATMULT_FFF_Interface.o obj/MATMULT_FFF_T_Interface.o obj/DEALLOCATE_IN4_FILES_Interface.o obj/FILE_CLOSE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/USET_PROC_USE_IFs.o: USE_IFs/USET_PROC_USE_IFs.f90 obj/OURTIM_Interface.o obj/ALLOCATE_DOF_TABLES_Interface.o obj/FILE_OPEN_Interface.o obj/READERR_Interface.o obj/OUTA_HERE_Interface.o obj/RDOF_Interface.o obj/GET_ARRAY_ROW_NUM_Interface.o obj/GET_GRID_NUM_COMPS_Interface.o obj/WRITE_USET_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/VECINORM_USE_IFs.o: USE_IFs/VECINORM_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/VECTOR_NORM_USE_IFs.o: USE_IFs/VECTOR_NORM_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_ALLOC_MEM_TABLE_USE_IFs.o: USE_IFs/WRITE_ALLOC_MEM_TABLE_USE_IFs.f90
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_BAR_USE_IFs.o: USE_IFs/WRITE_BAR_USE_IFs.f90 obj/OURTIM_Interface.o obj/WRT_REAL_TO_CHAR_VAR_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_DOF_TABLES_USE_IFs.o: USE_IFs/WRITE_DOF_TABLES_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_EDAT_USE_IFs.o: USE_IFs/WRITE_EDAT_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_ELEM_ENGR_FORCE_USE_IFs.o: USE_IFs/WRITE_ELEM_ENGR_FORCE_USE_IFs.f90 obj/OURTIM_Interface.o obj/GET_ELEM_ONAME_Interface.o obj/GET_GRID_AND_COMP_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_ELEM_NODE_FORCE_USE_IFs.o: USE_IFs/WRITE_ELEM_NODE_FORCE_USE_IFs.f90 obj/OURTIM_Interface.o obj/GET_ELEM_ONAME_Interface.o obj/GET_GRID_AND_COMP_Interface.o obj/WRT_REAL_TO_CHAR_VAR_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_ELEM_STRAINS_USE_IFs.o: USE_IFs/WRITE_ELEM_STRAINS_USE_IFs.f90 obj/OURTIM_Interface.o obj/GET_ELEM_ONAME_Interface.o obj/GET_GRID_AND_COMP_Interface.o obj/GET_MAX_MIN_ABS_STR_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_ELEM_STRESSES_USE_IFs.o: USE_IFs/WRITE_ELEM_STRESSES_USE_IFs.f90 obj/OURTIM_Interface.o obj/GET_ELEM_ONAME_Interface.o obj/GET_GRID_AND_COMP_Interface.o obj/WRITE_BAR_Interface.o obj/GET_MAX_MIN_ABS_STR_Interface.o obj/WRITE_ROD_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_ELM_OT4_USE_IFs.o: USE_IFs/WRITE_ELM_OT4_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_ENF_TO_L1O_USE_IFs.o: USE_IFs/WRITE_ENF_TO_L1O_USE_IFs.f90 obj/OURTIM_Interface.o obj/FILE_OPEN_Interface.o obj/READ_CHK_Interface.o obj/FILE_CLOSE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_EOFIL_USE_IFs.o: USE_IFs/WRITE_EOFIL_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_FEMAP_ELFO_VECS_USE_IFs.o: USE_IFs/WRITE_FEMAP_ELFO_VECS_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o obj/GET_VEC_MIN_MAX_ABS_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_FEMAP_GRID_VECS_USE_IFs.o: USE_IFs/WRITE_FEMAP_GRID_VECS_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o obj/GET_GRID_NUM_COMPS_Interface.o obj/GEN_T0L_Interface.o obj/GET_VEC_MIN_MAX_ABS_Interface.o obj/SORT_INT1_REAL1_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_FEMAP_STRE_VECS_USE_IFs.o: USE_IFs/WRITE_FEMAP_STRE_VECS_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o obj/GET_VEC_MIN_MAX_ABS_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_FEMAP_STRN_VECS_USE_IFs.o: USE_IFs/WRITE_FEMAP_STRN_VECS_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o obj/GET_VEC_MIN_MAX_ABS_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_FILNAM_USE_IFs.o: USE_IFs/WRITE_FILNAM_USE_IFs.f90
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_GRD_OT4_USE_IFs.o: USE_IFs/WRITE_GRD_OT4_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_GRD_PCH_OUTPUTS_USE_IFs.o: USE_IFs/WRITE_GRD_PCH_OUTPUTS_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_GRD_PRT_OUTPUTS_USE_IFs.o: USE_IFs/WRITE_GRD_PRT_OUTPUTS_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o obj/GET_GRID_AND_COMP_Interface.o obj/WRT_REAL_TO_CHAR_VAR_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_GRID_COORDS_USE_IFs.o: USE_IFs/WRITE_GRID_COORDS_USE_IFs.f90
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_INTEGER_VEC_USE_IFs.o: USE_IFs/WRITE_INTEGER_VEC_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_L1A_USE_IFs.o: USE_IFs/WRITE_L1A_USE_IFs.f90 obj/OURTIM_Interface.o obj/OPNERR_Interface.o obj/FILERR_Interface.o obj/OUTA_HERE_Interface.o obj/FILE_CLOSE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_L1M_USE_IFs.o: USE_IFs/WRITE_L1M_USE_IFs.f90 obj/FILE_OPEN_Interface.o obj/OURTIM_Interface.o obj/FILE_CLOSE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_L1Z_USE_IFs.o: USE_IFs/WRITE_L1Z_USE_IFs.f90 obj/OURTIM_Interface.o obj/FILE_OPEN_Interface.o obj/FILE_CLOSE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_MATRIX_1_USE_IFs.o: USE_IFs/WRITE_MATRIX_1_USE_IFs.f90 obj/OURTIM_Interface.o obj/FILE_OPEN_Interface.o obj/ARRAY_SIZE_ERROR_1_Interface.o obj/FILE_CLOSE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_MATRIX_BY_COLS_USE_IFs.o: USE_IFs/WRITE_MATRIX_BY_COLS_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_MATRIX_BY_ROWS_USE_IFs.o: USE_IFs/WRITE_MATRIX_BY_ROWS_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_MEFFMASS_USE_IFs.o: USE_IFs/WRITE_MEFFMASS_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_MEM_SUM_TO_F04_USE_IFs.o: USE_IFs/WRITE_MEM_SUM_TO_F04_USE_IFs.f90
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_MPFACTOR_USE_IFs.o: USE_IFs/WRITE_MPFACTOR_USE_IFs.f90 obj/OURTIM_Interface.o obj/TDOF_COL_NUM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_OU4_FULL_MAT_USE_IFs.o: USE_IFs/WRITE_OU4_FULL_MAT_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_OU4_SPARSE_MAT_USE_IFs.o: USE_IFs/WRITE_OU4_SPARSE_MAT_USE_IFs.f90 obj/OURTIM_Interface.o obj/SPARSE_MAT_DIAG_ZEROS_Interface.o obj/ALLOCATE_SCR_CRS_MAT_Interface.o obj/CRS_SYM_TO_CRS_NONSYM_Interface.o obj/ALLOCATE_SCR_CCS_MAT_Interface.o obj/SPARSE_CRS_SPARSE_CCS_Interface.o obj/DEALLOCATE_SCR_MAT_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_PARTNd_MAT_HDRS_USE_IFs.o: USE_IFs/WRITE_PARTNd_MAT_HDRS_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_PCOMP_EQUIV_USE_IFs.o: USE_IFs/WRITE_PCOMP_EQUIV_USE_IFs.f90 obj/SOLVE_SHELL_ALP_Interface.o obj/REAL_DATA_TO_C8FLD_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_PLY_STRAINS_USE_IFs.o: USE_IFs/WRITE_PLY_STRAINS_USE_IFs.f90 obj/OURTIM_Interface.o obj/GET_ELEM_ONAME_Interface.o obj/GET_GRID_AND_COMP_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_PLY_STRESSES_USE_IFs.o: USE_IFs/WRITE_PLY_STRESSES_USE_IFs.f90 obj/OURTIM_Interface.o obj/GET_ELEM_ONAME_Interface.o obj/GET_GRID_AND_COMP_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_ROD_USE_IFs.o: USE_IFs/WRITE_ROD_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_SPARSE_CRS_USE_IFs.o: USE_IFs/WRITE_SPARSE_CRS_USE_IFs.f90 obj/OURTIM_Interface.o obj/GET_GRID_AND_COMP_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_TDOF_USE_IFs.o: USE_IFs/WRITE_TDOF_USE_IFs.f90 obj/OURTIM_Interface.o obj/GET_GRID_NUM_COMPS_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_TSET_USE_IFs.o: USE_IFs/WRITE_TSET_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_USERIN_BD_CARDS_USE_IFs.o: USE_IFs/WRITE_USERIN_BD_CARDS_USE_IFs.f90 obj/TDOF_COL_NUM_Interface.o obj/GET_ARRAY_ROW_NUM_Interface.o obj/LEFT_ADJ_BDFLD_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_USETSTR_USE_IFs.o: USE_IFs/WRITE_USETSTR_USE_IFs.f90 obj/OURTIM_Interface.o obj/OUTA_HERE_Interface.o obj/TDOF_COL_NUM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_USET_USE_IFs.o: USE_IFs/WRITE_USET_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_VECTOR_USE_IFs.o: USE_IFs/WRITE_VECTOR_USE_IFs.f90 obj/OURTIM_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRT_REAL_TO_CHAR_VAR_USE_IFs.o: USE_IFs/WRT_REAL_TO_CHAR_VAR_USE_IFs.f90
	$(F77) $(FLAGS) -c $< -o $@
obj/YS_ARRAY_USE_IFs.o: USE_IFs/YS_ARRAY_USE_IFs.f90 obj/OURTIM_Interface.o obj/READERR_Interface.o obj/TDOF_COL_NUM_Interface.o obj/GET_ARRAY_ROW_NUM_Interface.o obj/FILERR_Interface.o obj/OUTA_HERE_Interface.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATED_MEMORY.o: UTIL/ALLOCATED_MEMORY.f90 obj/PENTIUM_II_KIND.o obj/SCONTR.o obj/IOUNT1.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/PARAMS.o obj/ALLOCATED_ARRAY_DATA.o obj/ALLOCATED_MEMORY_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_CB_ELM_OTM.o: UTIL/ALLOCATE_CB_ELM_OTM.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/CC_OUTPUT_DESCRIBERS.o obj/OUTPUT4_MATRICES.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/ALLOCATE_CB_ELM_OTM_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_CB_GRD_OTM.o: UTIL/ALLOCATE_CB_GRD_OTM.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/PARAMS.o obj/MODEL_STUF.o obj/OUTPUT4_MATRICES.o obj/SUBR_BEGEND_LEVELS.o obj/ALLOCATE_CB_GRD_OTM_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_COL_VEC.o: UTIL/ALLOCATE_COL_VEC.f90 obj/PENTIUM_II_KIND.o obj/CONSTANTS_1.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/SUBR_BEGEND_LEVELS.o obj/OUTPUT4_MATRICES.o obj/COL_VECS.o obj/COL_VECS.o obj/ALLOCATE_COL_VEC_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_DOF_TABLES.o: UTIL/ALLOCATE_DOF_TABLES.f90 obj/PENTIUM_II_KIND.o obj/CONSTANTS_1.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/SUBR_BEGEND_LEVELS.o obj/DOF_TABLES.o obj/ALLOCATE_DOF_TABLES_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_EIGEN1_MAT.o: UTIL/ALLOCATE_EIGEN1_MAT.f90 obj/PENTIUM_II_KIND.o obj/CONSTANTS_1.o obj/SCONTR.o obj/IOUNT1.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/SUBR_BEGEND_LEVELS.o obj/EIGEN_MATRICES_1.o obj/ALLOCATE_EIGEN1_MAT_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_FULL_MAT.o: UTIL/ALLOCATE_FULL_MAT.f90 obj/PENTIUM_II_KIND.o obj/CONSTANTS_1.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/SUBR_BEGEND_LEVELS.o obj/FULL_MATRICES.o obj/ALLOCATE_FULL_MAT_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_IN4_FILES.o: UTIL/ALLOCATE_IN4_FILES.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/INPUTT4_MATRICES.o obj/SUBR_BEGEND_LEVELS.o obj/ALLOCATE_IN4_FILES_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_LAPACK_MAT.o: UTIL/ALLOCATE_LAPACK_MAT.f90 obj/PENTIUM_II_KIND.o obj/CONSTANTS_1.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/ARPACK_MATRICES_1.o obj/LAPACK_DPB_MATRICES.o obj/ALLOCATE_LAPACK_MAT_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_MISC_MAT.o: UTIL/ALLOCATE_MISC_MAT.f90 obj/PENTIUM_II_KIND.o obj/CONSTANTS_1.o obj/SCONTR.o obj/IOUNT1.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/MISC_MATRICES.o obj/SUBR_BEGEND_LEVELS.o obj/ALLOCATE_MISC_MAT_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_MODEL_STUF.o: UTIL/ALLOCATE_MODEL_STUF.f90 obj/PENTIUM_II_KIND.o obj/CONSTANTS_1.o obj/IOUNT1.o obj/SCONTR.o obj/SCONTR.o obj/SCONTR.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/ALLOCATE_MODEL_STUF_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_NL_PARAMS.o: UTIL/ALLOCATE_NL_PARAMS.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/NONLINEAR_PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/ALLOCATE_NL_PARAMS_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_RBGLOBAL.o: UTIL/ALLOCATE_RBGLOBAL.f90 obj/PENTIUM_II_KIND.o obj/CONSTANTS_1.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/SUBR_BEGEND_LEVELS.o obj/RIGID_BODY_DISP_MATS.o obj/ALLOCATE_RBGLOBAL_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_SCR_CCS_MAT.o: UTIL/ALLOCATE_SCR_CCS_MAT.f90 obj/PENTIUM_II_KIND.o obj/CONSTANTS_1.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/SUBR_BEGEND_LEVELS.o obj/SCRATCH_MATRICES.o obj/ALLOCATE_SCR_CCS_MAT_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_SCR_CRS_MAT.o: UTIL/ALLOCATE_SCR_CRS_MAT.f90 obj/PENTIUM_II_KIND.o obj/CONSTANTS_1.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/SUBR_BEGEND_LEVELS.o obj/SCRATCH_MATRICES.o obj/ALLOCATE_SCR_CRS_MAT_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_SPARSE_ALG.o: UTIL/ALLOCATE_SPARSE_ALG.f90 obj/PENTIUM_II_KIND.o obj/CONSTANTS_1.o obj/SCONTR.o obj/IOUNT1.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/SUBR_BEGEND_LEVELS.o obj/SPARSE_ALG_ARRAYS.o obj/ALLOCATE_SPARSE_ALG_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ALLOCATE_SPARSE_MAT.o: UTIL/ALLOCATE_SPARSE_MAT.f90 obj/PENTIUM_II_KIND.o obj/CONSTANTS_1.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/SUBR_BEGEND_LEVELS.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/ALLOCATE_SPARSE_MAT_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ARRAY_SIZE_ERROR_1.o: UTIL/ARRAY_SIZE_ERROR_1.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/ARRAY_SIZE_ERROR_1_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/AUTOSPC_SUMMARY_MSGS.o: UTIL/AUTOSPC_SUMMARY_MSGS.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/PARAMS.o obj/AUTOSPC_SUMMARY_MSGS_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BANDGEN_LAPACK_DGB.o: UTIL/BANDGEN_LAPACK_DGB.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/BANDGEN_LAPACK_DGB_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BANDGEN_LAPACK_DPB.o: UTIL/BANDGEN_LAPACK_DPB.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/BANDGEN_LAPACK_DPB_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/BANDSIZ.o: UTIL/BANDSIZ.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/BANDSIZ_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CALC_TDOF_ROW_START.o: UTIL/CALC_TDOF_ROW_START.f90 obj/PENTIUM_II_KIND.o obj/SCONTR.o obj/IOUNT1.o obj/TIMDAT.o obj/DOF_TABLES.o obj/DEBUG_PARAMETERS.o obj/MODEL_STUF.o obj/SUBR_BEGEND_LEVELS.o obj/CALC_TDOF_ROW_START_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CALC_VEC_SORT_ORDER.o: UTIL/CALC_VEC_SORT_ORDER.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CALC_VEC_SORT_ORDER_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CARD_FLDS_NOT_BLANK.o: UTIL/CARD_FLDS_NOT_BLANK.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/CARD_FLDS_NOT_BLANK_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CHECK_MAT_INVERSE.o: UTIL/CHECK_MAT_INVERSE.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/PARAMS.o obj/CHECK_MAT_INVERSE_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CHK_ARRAY_ALLOC_STAT.o: UTIL/CHK_ARRAY_ALLOC_STAT.f90 obj/SCONTR.o obj/IOUNT1.o obj/ARPACK_MATRICES_1.o obj/COL_VECS.o obj/DOF_TABLES.o obj/EIGEN_MATRICES_1.o obj/EMS_ARRAYS.o obj/FEMAP_ARRAYS.o obj/FULL_MATRICES.o obj/LAPACK_DPB_MATRICES.o obj/LINK9_STUFF.o obj/MODEL_STUF.o obj/NONLINEAR_PARAMS.o obj/INPUTT4_MATRICES.o obj/RIGID_BODY_DISP_MATS.o obj/SCRATCH_MATRICES.o obj/SPARSE_ALG_ARRAYS.o obj/SPARSE_MATRICES.o obj/STF_ARRAYS.o obj/STF_TEMPLATE_ARRAYS.o obj/OUTPUT4_MATRICES.o obj/CHK_ARRAY_ALLOC_STAT_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CLOSE_LIJFILES.o: UTIL/CLOSE_LIJFILES.f90 obj/PENTIUM_II_KIND.o obj/SCONTR.o obj/IOUNT1.o obj/IOUNT1.o obj/IOUNT1.o obj/TIMDAT.o obj/CLOSE_LIJFILES_USE_IFs.o obj/PENTIUM_II_KIND.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CLOSE_OUTFILES.o: UTIL/CLOSE_OUTFILES.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/CLOSE_OUTFILES_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CNT_NONZ_IN_FULL_MAT.o: UTIL/CNT_NONZ_IN_FULL_MAT.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/DEBUG_PARAMETERS.o obj/SUBR_BEGEND_LEVELS.o obj/CNT_NONZ_IN_FULL_MAT_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/COND_NUM.o: UTIL/COND_NUM.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/CONSTANTS_1.o obj/PARAMS.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/LAPACK_LIN_EQN_DPB.o obj/COND_NUM_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CONVERT_INT_TO_CHAR.o: UTIL/CONVERT_INT_TO_CHAR.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONVERT_INT_TO_CHAR_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CONVERT_VEC_COORD_SYS.o: UTIL/CONVERT_VEC_COORD_SYS.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/MODEL_STUF.o obj/SUBR_BEGEND_LEVELS.o obj/CONVERT_VEC_COORD_SYS_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CROSS.o: UTIL/CROSS.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CROSS_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CRS_NONSYM_TO_CRS_SYM.o: UTIL/CRS_NONSYM_TO_CRS_SYM.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/CRS_NONSYM_TO_CRS_SYM_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/CRS_SYM_TO_CRS_NONSYM.o: UTIL/CRS_SYM_TO_CRS_NONSYM.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/CRS_SYM_TO_CRS_NONSYM_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DATA_SET_NAME_ERROR.o: UTIL/DATA_SET_NAME_ERROR.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/DATA_SET_NAME_ERROR_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DATA_SET_SIZE_ERROR.o: UTIL/DATA_SET_SIZE_ERROR.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/DATA_SET_SIZE_ERROR_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEALLOCATE_CB_ELM_OTM.o: UTIL/DEALLOCATE_CB_ELM_OTM.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/OUTPUT4_MATRICES.o obj/DEALLOCATE_CB_ELM_OTM_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEALLOCATE_CB_GRD_OTM.o: UTIL/DEALLOCATE_CB_GRD_OTM.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/OUTPUT4_MATRICES.o obj/DEALLOCATE_CB_GRD_OTM_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEALLOCATE_COL_VEC.o: UTIL/DEALLOCATE_COL_VEC.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/OUTPUT4_MATRICES.o obj/COL_VECS.o obj/COL_VECS.o obj/DEALLOCATE_COL_VEC_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEALLOCATE_DOF_TABLES.o: UTIL/DEALLOCATE_DOF_TABLES.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/DOF_TABLES.o obj/DEALLOCATE_DOF_TABLES_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEALLOCATE_EIGEN1_MAT.o: UTIL/DEALLOCATE_EIGEN1_MAT.f90 obj/PENTIUM_II_KIND.o obj/SCONTR.o obj/IOUNT1.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/EIGEN_MATRICES_1.o obj/DEALLOCATE_EIGEN1_MAT_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEALLOCATE_FULL_MAT.o: UTIL/DEALLOCATE_FULL_MAT.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/FULL_MATRICES.o obj/DEALLOCATE_FULL_MAT_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEALLOCATE_IN4_FILES.o: UTIL/DEALLOCATE_IN4_FILES.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/CONSTANTS_1.o obj/INPUTT4_MATRICES.o obj/SUBR_BEGEND_LEVELS.o obj/DEALLOCATE_IN4_FILES_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEALLOCATE_LAPACK_MAT.o: UTIL/DEALLOCATE_LAPACK_MAT.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/ARPACK_MATRICES_1.o obj/LAPACK_DPB_MATRICES.o obj/DEALLOCATE_LAPACK_MAT_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEALLOCATE_MISC_MAT.o: UTIL/DEALLOCATE_MISC_MAT.f90 obj/PENTIUM_II_KIND.o obj/SCONTR.o obj/IOUNT1.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/CONSTANTS_1.o obj/MISC_MATRICES.o obj/SUBR_BEGEND_LEVELS.o obj/DEALLOCATE_MISC_MAT_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEALLOCATE_MODEL_STUF.o: UTIL/DEALLOCATE_MODEL_STUF.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/MODEL_STUF.o obj/DEALLOCATE_MODEL_STUF_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEALLOCATE_NL_PARAMS.o: UTIL/DEALLOCATE_NL_PARAMS.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/CONSTANTS_1.o obj/NONLINEAR_PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/DEALLOCATE_NL_PARAMS_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEALLOCATE_RBGLOBAL.o: UTIL/DEALLOCATE_RBGLOBAL.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/RIGID_BODY_DISP_MATS.o obj/DEALLOCATE_RBGLOBAL_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEALLOCATE_SCR_MAT.o: UTIL/DEALLOCATE_SCR_MAT.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/SCRATCH_MATRICES.o obj/DEALLOCATE_SCR_MAT_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEALLOCATE_SPARSE_ALG.o: UTIL/DEALLOCATE_SPARSE_ALG.f90 obj/PENTIUM_II_KIND.o obj/SCONTR.o obj/IOUNT1.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/SPARSE_ALG_ARRAYS.o obj/DEALLOCATE_SPARSE_ALG_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/DEALLOCATE_SPARSE_MAT.o: UTIL/DEALLOCATE_SPARSE_MAT.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/DEALLOCATE_SPARSE_MAT_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/FBS_LAPACK.o: UTIL/FBS_LAPACK.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/PARAMS.o obj/LAPACK_DPB_MATRICES.o obj/DEBUG_PARAMETERS.o obj/MACHINE_PARAMS.o obj/LAPACK_LIN_EQN_DPB.o obj/SUBR_BEGEND_LEVELS.o obj/SYM_MAT_DECOMP_LAPACK_USE_IFs.o obj/FBS_LAPACK_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/FILERR.o: UTIL/FILERR.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/FILERR_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/FILE_CLOSE.o: UTIL/FILE_CLOSE.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/FILE_CLOSE_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/FILE_INQUIRE.o: UTIL/FILE_INQUIRE.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/IOUNT1.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/FILE_INQUIRE_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/FILE_OPEN.o: UTIL/FILE_OPEN.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/MYSTRAN_Version.o obj/SUBR_BEGEND_LEVELS.o obj/FILE_OPEN_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/FULL_TO_SPARSE_CRS.o: UTIL/FULL_TO_SPARSE_CRS.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/SUBR_BEGEND_LEVELS.o obj/FULL_TO_SPARSE_CRS_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GEN_T0L.o: UTIL/GEN_T0L.f90 obj/PENTIUM_II_KIND.o obj/CONSTANTS_1.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/GEN_T0L_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_ARRAY_ROW_NUM.o: UTIL/GET_ARRAY_ROW_NUM.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/GET_ARRAY_ROW_NUM_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_CHAR_STRING_END.o: UTIL/GET_CHAR_STRING_END.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/GET_CHAR_STRING_END_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_COMMAND_LINE.o: UTIL/GET_COMMAND_LINE.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/GET_COMMAND_LINE_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_FORMATTED_INTEGER.o: UTIL/GET_FORMATTED_INTEGER.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/GET_FORMATTED_INTEGER_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_GRID_AND_COMP.o: UTIL/GET_GRID_AND_COMP.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/DOF_TABLES.o obj/GET_GRID_AND_COMP_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_GRID_NUM_COMPS.o: UTIL/GET_GRID_NUM_COMPS.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/MODEL_STUF.o obj/SUBR_BEGEND_LEVELS.o obj/GET_GRID_NUM_COMPS_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_I2_MAT_FROM_I_MAT.o: UTIL/GET_I2_MAT_FROM_I_MAT.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/GET_I2_MAT_FROM_I_MAT_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_I_MAT_FROM_I2_MAT.o: UTIL/GET_I_MAT_FROM_I2_MAT.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/GET_I_MAT_FROM_I2_MAT_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_MACHINE_PARAMS.o: UTIL/GET_MACHINE_PARAMS.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/MACHINE_PARAMS.o obj/DEBUG_PARAMETERS.o obj/LAPACK_BLAS_AUX.o obj/GET_MACHINE_PARAMS_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_MATRIX_DIAG_STATS.o: UTIL/GET_MATRIX_DIAG_STATS.f90 obj/PENTIUM_II_KIND.o obj/SCONTR.o obj/IOUNT1.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/PARAMS.o obj/DOF_TABLES.o obj/DEBUG_PARAMETERS.o obj/SUBR_BEGEND_LEVELS.o obj/GET_MATRIX_DIAG_STATS_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_OU4_MAT_STATS.o: UTIL/GET_OU4_MAT_STATS.f90 obj/PENTIUM_II_KIND.o obj/SCONTR.o obj/IOUNT1.o obj/MODEL_STUF.o obj/PARAMS.o obj/OUTPUT4_MATRICES.o obj/GET_OU4_MAT_STATS_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_SPARSE_CRS_COL.o: UTIL/GET_SPARSE_CRS_COL.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/GET_SPARSE_CRS_COL_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_SPARSE_CRS_ROW.o: UTIL/GET_SPARSE_CRS_ROW.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/GET_SPARSE_CRS_ROW_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_SPARSE_MAT_TERM.o: UTIL/GET_SPARSE_MAT_TERM.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/GET_SPARSE_MAT_TERM_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_UG_123_IN_GRD_ORD.o: UTIL/GET_UG_123_IN_GRD_ORD.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/MODEL_STUF.o obj/DOF_TABLES.o obj/COL_VECS.o obj/MISC_MATRICES.o obj/SUBR_BEGEND_LEVELS.o obj/GET_UG_123_IN_GRD_ORD_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/GET_VEC_MIN_MAX_ABS.o: UTIL/GET_VEC_MIN_MAX_ABS.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/MACHINE_PARAMS.o obj/GET_VEC_MIN_MAX_ABS_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/INVERT_FF_MAT.o: UTIL/INVERT_FF_MAT.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/LAPACK_SYM_MAT_INV.o obj/INVERT_FF_MAT_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MATADD_FFF.o: UTIL/MATADD_FFF.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/MATADD_FFF_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MATADD_SSS.o: UTIL/MATADD_SSS.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/SPARSE_ALG_ARRAYS.o obj/SUBR_BEGEND_LEVELS.o obj/MATADD_SSS_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MATADD_SSS_NTERM.o: UTIL/MATADD_SSS_NTERM.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/DEBUG_PARAMETERS.o obj/SPARSE_ALG_ARRAYS.o obj/SUBR_BEGEND_LEVELS.o obj/MATADD_SSS_NTERM_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MATMULT_FFF.o: UTIL/MATMULT_FFF.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/MATMULT_FFF_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MATMULT_FFF_T.o: UTIL/MATMULT_FFF_T.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/MATMULT_FFF_T_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MATMULT_SFF.o: UTIL/MATMULT_SFF.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/DEBUG_PARAMETERS.o obj/SPARSE_ALG_ARRAYS.o obj/MATMULT_SFF_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MATMULT_SFS.o: UTIL/MATMULT_SFS.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/CONSTANTS_1.o obj/PARAMS.o obj/DEBUG_PARAMETERS.o obj/MATMULT_SFS_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MATMULT_SFS_NTERM.o: UTIL/MATMULT_SFS_NTERM.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/PARAMS.o obj/SPARSE_ALG_ARRAYS.o obj/DEBUG_PARAMETERS.o obj/MATMULT_SFS_NTERM_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MATMULT_SSS.o: UTIL/MATMULT_SSS.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/DEBUG_PARAMETERS.o obj/MATMULT_SSS_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MATMULT_SSS_NTERM.o: UTIL/MATMULT_SSS_NTERM.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/SPARSE_ALG_ARRAYS.o obj/DEBUG_PARAMETERS.o obj/MATMULT_SSS_NTERM_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MATTRNSP_SS.o: UTIL/MATTRNSP_SS.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/DEBUG_PARAMETERS.o obj/MATTRNSP_SS_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MERGE_COL_VECS.o: UTIL/MERGE_COL_VECS.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/DOF_TABLES.o obj/MERGE_COL_VECS_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MERGE_MAT_COLS_SSS.o: UTIL/MERGE_MAT_COLS_SSS.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/SUBR_BEGEND_LEVELS.o obj/MERGE_MAT_COLS_SSS_USE_IFs.o obj/PENTIUM_II_KIND.o
	$(F77) $(FLAGS) -c $< -o $@
obj/MERGE_MAT_ROWS_SSS.o: UTIL/MERGE_MAT_ROWS_SSS.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/SPARSE_ALG_ARRAYS.o obj/SUBR_BEGEND_LEVELS.o obj/MERGE_MAT_ROWS_SSS_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/OPEN_OUTFILES.o: UTIL/OPEN_OUTFILES.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/TIMDAT.o obj/OPEN_OUTFILES_USE_IFs.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o
	$(F77) $(FLAGS) -c $< -o $@
obj/OPNERR.o: UTIL/OPNERR.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/OPNERR_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/OURDAT.o: UTIL/OURDAT.f90 obj/PENTIUM_II_KIND.o obj/TIMDAT.o obj/OURDAT_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/OURTIM.o: UTIL/OURTIM.f90 obj/PENTIUM_II_KIND.o obj/TIMDAT.o obj/OURTIM_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/OUTA_HERE.o: UTIL/OUTA_HERE.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/OUTA_HERE_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/OUTPUT4_MATRIX_MSGS.o: UTIL/OUTPUT4_MATRIX_MSGS.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/OUTPUT4_MATRICES.o obj/PARAMS.o obj/OUTPUT4_MATRIX_MSGS_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/OUTPUT4_PROC.o: UTIL/OUTPUT4_PROC.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/SCONTR.o obj/MODEL_STUF.o obj/PARAMS.o obj/EIGEN_MATRICES_1.o obj/FULL_MATRICES.o obj/MODEL_STUF.o obj/RIGID_BODY_DISP_MATS.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/SCRATCH_MATRICES.o obj/OUTPUT4_MATRICES.o obj/TIMDAT.o obj/RIGID_BODY_DISP_MATS.o obj/EIGEN_MATRICES_1.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/FULL_MATRICES.o obj/SUBR_BEGEND_LEVELS.o obj/OUTPUT4_PROC_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/PARAM_CORDS_ACT_CORDS.o: UTIL/PARAM_CORDS_ACT_CORDS.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/SUBR_BEGEND_LEVELS.o obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/MODEL_STUF.o
	$(F77) $(FLAGS) -c $< -o $@
obj/PARSE_CHAR_STRING.o: UTIL/PARSE_CHAR_STRING.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/SUBR_BEGEND_LEVELS.o obj/PARSE_CHAR_STRING_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/PARTITION_FF.o: UTIL/PARTITION_FF.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/DEBUG_PARAMETERS.o obj/PARTITION_FF_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/PARTITION_SS.o: UTIL/PARTITION_SS.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/DEBUG_PARAMETERS.o obj/PARTITION_SS_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/PARTITION_SS_NTERM.o: UTIL/PARTITION_SS_NTERM.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SPARSE_ALG_ARRAYS.o obj/DEBUG_PARAMETERS.o obj/SUBR_BEGEND_LEVELS.o obj/PARTITION_SS_NTERM_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/PARTITION_VEC.o: UTIL/PARTITION_VEC.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/DOF_TABLES.o obj/PARTITION_VEC_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/PLANE_COORD_TRANS_21.o: UTIL/PLANE_COORD_TRANS_21.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/PLANE_COORD_TRANS_21_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/PROJ_VEC_ONTO_PLANE.o: UTIL/PROJ_VEC_ONTO_PLANE.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/PROJ_VEC_ONTO_PLANE_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/PRT_MATS_ON_RESTART.o: UTIL/PRT_MATS_ON_RESTART.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/IOUNT1.o obj/IOUNT1.o obj/IOUNT1.o obj/IOUNT1.o obj/SCONTR.o obj/SCONTR.o obj/SCONTR.o obj/TIMDAT.o obj/PARAMS.o obj/COL_VECS.o obj/SPARSE_MATRICES.o obj/SUBR_BEGEND_LEVELS.o obj/PRT_MATS_ON_RESTART_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/READERR.o: UTIL/READERR.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/READERR_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/READ_CHK.o: UTIL/READ_CHK.f90 obj/PENTIUM_II_KIND.o obj/READ_CHK_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/READ_CL.o: UTIL/READ_CL.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/READ_CL_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/READ_DOF_TABLES.o: UTIL/READ_DOF_TABLES.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/DOF_TABLES.o obj/READ_DOF_TABLES_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/READ_IN4_FULL_MAT.o: UTIL/READ_IN4_FULL_MAT.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/MODEL_STUF.o obj/SUBR_BEGEND_LEVELS.o obj/READ_IN4_FULL_MAT_USE_IFs.o obj/PENTIUM_II_KIND.o obj/IOUNT1.o
	$(F77) $(FLAGS) -c $< -o $@
obj/READ_L1A.o: UTIL/READ_L1A.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/IOUNT1.o obj/IOUNT1.o obj/IOUNT1.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/DEBUG_PARAMETERS.o obj/READ_L1A_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/READ_L1M.o: UTIL/READ_L1M.f90 obj/PENTIUM_II_KIND.o obj/SCONTR.o obj/IOUNT1.o obj/TIMDAT.o obj/EIGEN_MATRICES_1.o obj/MODEL_STUF.o obj/READ_L1M_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/READ_L1Z.o: UTIL/READ_L1Z.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/MODEL_STUF.o obj/SUBR_BEGEND_LEVELS.o obj/READ_L1Z_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/READ_MATRIX_1.o: UTIL/READ_MATRIX_1.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/SUBR_BEGEND_LEVELS.o obj/READ_MATRIX_1_USE_IFs.o obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/DEBUG_PARAMETERS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/READ_MATRIX_2.o: UTIL/READ_MATRIX_2.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/READ_MATRIX_2_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/READ_XTIME.o: UTIL/READ_XTIME.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/READ_XTIME_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/REAL_DATA_TO_C8FLD.o: UTIL/REAL_DATA_TO_C8FLD.f90 obj/PENTIUM_II_KIND.o obj/REAL_DATA_TO_C8FLD_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/RESTART_DATA_FOR_L3.o: UTIL/RESTART_DATA_FOR_L3.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/IOUNT1.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SPARSE_MATRICES.o obj/SUBR_BEGEND_LEVELS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/RIGID_BODY_DISP_MAT.o: UTIL/RIGID_BODY_DISP_MAT.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/RIGID_BODY_DISP_MAT_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/ROW_AT_COLJ_BEGEND.o: UTIL/ROW_AT_COLJ_BEGEND.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/ROW_AT_COLJ_BEGEND_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SET_FILE_CLOSE_STAT.o: UTIL/SET_FILE_CLOSE_STAT.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SET_FILE_CLOSE_STAT_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SET_SPARSE_MAT_SYM.o: UTIL/SET_SPARSE_MAT_SYM.f90 obj/IOUNT1.o obj/PARAMS.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o obj/SPARSE_MATRICES.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SORTLEN.o: UTIL/SORTLEN.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/CONSTANTS_1.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/SORTLEN_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SORT_GRID_RGRID.o: UTIL/SORT_GRID_RGRID.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/SORT_GRID_RGRID_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SORT_INT1.o: UTIL/SORT_INT1.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/SORT_INT1_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SORT_INT1_REAL1.o: UTIL/SORT_INT1_REAL1.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/SORT_INT1_REAL1_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SORT_INT1_REAL3.o: UTIL/SORT_INT1_REAL3.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/SORT_INT1_REAL3_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SORT_INT2.o: UTIL/SORT_INT2.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/SORT_INT2_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SORT_INT2_REAL1.o: UTIL/SORT_INT2_REAL1.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/SORT_INT2_REAL1_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SORT_INT3.o: UTIL/SORT_INT3.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/SORT_INT3_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SORT_INT3_CHAR2.o: UTIL/SORT_INT3_CHAR2.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/SORT_INT3_CHAR2_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SORT_REAL1_INT1.o: UTIL/SORT_REAL1_INT1.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/SORT_REAL1_INT1_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SORT_TDOF.o: UTIL/SORT_TDOF.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/PARAMS.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/SORT_TDOF_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SPARSE_CRS_SPARSE_CCS.o: UTIL/SPARSE_CRS_SPARSE_CCS.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/DEBUG_PARAMETERS.o obj/SPARSE_CRS_SPARSE_CCS_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SPARSE_CRS_TERM_COUNT.o: UTIL/SPARSE_CRS_TERM_COUNT.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/SPARSE_CRS_TERM_COUNT_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SPARSE_CRS_TO_FULL.o: UTIL/SPARSE_CRS_TO_FULL.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/SPARSE_CRS_TO_FULL_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SPARSE_MAT_DIAG_ZEROS.o: UTIL/SPARSE_MAT_DIAG_ZEROS.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/SUBR_BEGEND_LEVELS.o obj/SPARSE_MAT_DIAG_ZEROS_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/STMERR.o: UTIL/STMERR.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/STMERR_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SURFACE_FIT.o: UTIL/SURFACE_FIT.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/LSQ_MYSTRAN.o obj/SURFACE_FIT_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/SYM_MAT_DECOMP_LAPACK.o: UTIL/SYM_MAT_DECOMP_LAPACK.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/PARAMS.o obj/LAPACK_DPB_MATRICES.o obj/DEBUG_PARAMETERS.o obj/MACHINE_PARAMS.o obj/LAPACK_LIN_EQN_DPB.o obj/SUBR_BEGEND_LEVELS.o obj/SYM_MAT_DECOMP_LAPACK_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/TIME_INIT.o: UTIL/TIME_INIT.f90 obj/TIMDAT.o obj/TIME_INIT_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/VECTOR_NORM.o: UTIL/VECTOR_NORM.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/SUBR_BEGEND_LEVELS.o obj/VECTOR_NORM_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_ALLOC_MEM_TABLE.o: UTIL/WRITE_ALLOC_MEM_TABLE.f90 obj/PENTIUM_II_KIND.o obj/SCONTR.o obj/IOUNT1.o obj/CONSTANTS_1.o obj/DEBUG_PARAMETERS.o obj/ALLOCATED_ARRAY_DATA.o obj/WRITE_ALLOC_MEM_TABLE_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_DOF_TABLES.o: UTIL/WRITE_DOF_TABLES.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/DOF_TABLES.o obj/WRITE_DOF_TABLES_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_EDAT.o: UTIL/WRITE_EDAT.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/MODEL_STUF.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/WRITE_EDAT_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_ELM_OT4.o: UTIL/WRITE_ELM_OT4.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CC_OUTPUT_DESCRIBERS.o obj/SUBR_BEGEND_LEVELS.o obj/WRITE_ELM_OT4_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_EOFIL.o: UTIL/WRITE_EOFIL.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/MODEL_STUF.o obj/PARAMS.o obj/WRITE_EOFIL_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_FILNAM.o: UTIL/WRITE_FILNAM.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/WRITE_FILNAM_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_GRD_OT4.o: UTIL/WRITE_GRD_OT4.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/WRITE_GRD_OT4_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_GRID_COORDS.o: UTIL/WRITE_GRID_COORDS.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/MODEL_STUF.o obj/WRITE_GRID_COORDS_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_INTEGER_VEC.o: UTIL/WRITE_INTEGER_VEC.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/WRITE_INTEGER_VEC_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_L1A.o: UTIL/WRITE_L1A.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/IOUNT1.o obj/IOUNT1.o obj/IOUNT1.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/PARAMS.o obj/WRITE_L1A_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_L1M.o: UTIL/WRITE_L1M.f90 obj/PENTIUM_II_KIND.o obj/SCONTR.o obj/IOUNT1.o obj/TIMDAT.o obj/DEBUG_PARAMETERS.o obj/EIGEN_MATRICES_1.o obj/MODEL_STUF.o obj/WRITE_L1M_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_L1Z.o: UTIL/WRITE_L1Z.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/MODEL_STUF.o obj/SUBR_BEGEND_LEVELS.o obj/WRITE_L1Z_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_MATRIX_1.o: UTIL/WRITE_MATRIX_1.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/WRITE_MATRIX_1_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_MATRIX_BY_COLS.o: UTIL/WRITE_MATRIX_BY_COLS.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/WRITE_VECTOR_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_MATRIX_BY_ROWS.o: UTIL/WRITE_MATRIX_BY_ROWS.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/WRITE_VECTOR_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_MEM_SUM_TO_F04.o: UTIL/WRITE_MEM_SUM_TO_F04.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/DEBUG_PARAMETERS.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_OU4_FULL_MAT.o: UTIL/WRITE_OU4_FULL_MAT.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/WRITE_OU4_FULL_MAT_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_OU4_SPARSE_MAT.o: UTIL/WRITE_OU4_SPARSE_MAT.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/PARAMS.o obj/SCRATCH_MATRICES.o obj/SUBR_BEGEND_LEVELS.o obj/WRITE_OU4_SPARSE_MAT_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_PARTNd_MAT_HDRS.o: UTIL/WRITE_PARTNd_MAT_HDRS.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/DOF_TABLES.o obj/OUTPUT4_MATRICES.o obj/SUBR_BEGEND_LEVELS.o obj/WRITE_PARTNd_MAT_HDRS_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_SPARSE_CRS.o: UTIL/WRITE_SPARSE_CRS.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/CONSTANTS_1.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/WRITE_SPARSE_CRS_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_TDOF.o: UTIL/WRITE_TDOF.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/DOF_TABLES.o obj/PARAMS.o obj/MODEL_STUF.o obj/SUBR_BEGEND_LEVELS.o obj/WRITE_TDOF_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_TSET.o: UTIL/WRITE_TSET.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/MODEL_STUF.o obj/DOF_TABLES.o obj/SUBR_BEGEND_LEVELS.o obj/WRITE_TSET_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_USERIN_BD_CARDS.o: UTIL/WRITE_USERIN_BD_CARDS.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/DOF_TABLES.o obj/PARAMS.o obj/MODEL_STUF.o obj/OUTPUT4_MATRICES.o obj/WRITE_USERIN_BD_CARDS_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_USET.o: UTIL/WRITE_USET.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/MODEL_STUF.o obj/PARAMS.o obj/SUBR_BEGEND_LEVELS.o obj/DOF_TABLES.o obj/WRITE_USET_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_USETSTR.o: UTIL/WRITE_USETSTR.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/DOF_TABLES.o obj/WRITE_USETSTR_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
obj/WRITE_VECTOR.o: UTIL/WRITE_VECTOR.f90 obj/PENTIUM_II_KIND.o obj/IOUNT1.o obj/SCONTR.o obj/TIMDAT.o obj/SUBR_BEGEND_LEVELS.o obj/WRITE_VECTOR_USE_IFs.o
	$(F77) $(FLAGS) -c $< -o $@
