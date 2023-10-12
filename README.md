## Coverage of thread communication for RIOT 

To run the script coverage.sh following needs to be added to Makefile.tests_common. (Under Kconfig builds works)

`
CFLAGS += -fprofile-arcs -ftest-coverage -fprofile-abs-path -lgcov -coverage -fPIC
LINKFLAGS += -fprofile-arcs -ftest-coverage -fprofile-abs-path -lgcov -coverage -fPIC
`

Additionally this Folder ("RIOT_coverage" folder) has to be on the same level as the RIOT folder.
The Output will be put into a Folder called data.
