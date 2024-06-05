project(
  'lossywav',
  'cpp',
  license : 'GPL-3.0-or-later',
  default_options : ['buildtype=release', 'prefix=/usr']
)

prefix = get_option('prefix')

fftw = dependency('fftw3', required: false)

if fftw.found()
  fftw_dep = declare_dependency(
    compile_args: '-DHAVE_FFTW3',
    dependencies: [fftw],
  )
else
  fftw_dep = disabler()
endif

executable(
  meson.project_name(),
  sources: [
    'lossyWAV.cpp',
    'units/fftw_interface.cpp',
    'units/nCore.cpp',
    'units/nFFT.cpp',
    'units/nFillFFT.cpp',
    'units/nInitialise.cpp',
    'units/nOutput.cpp',
    'units/nParameter.cpp',
    'units/nProcess.cpp',
    'units/nRemoveBits.cpp',
    'units/nSGNS.cpp',
    'units/nShiftBlocks.cpp',
    'units/nSpreading.cpp',
    'units/nWav.cpp',
  ],
  cpp_args : [
    '-DHAVE_CHMOD',
    '-DHAVE_NANOSLEEP',
    '-DHAVE_SETPRIORITY',
    '-DHAVE_STAT',
    '-DHAVE_STD_CHRONO_STEADY_CLOCK_NOW',
  ],
  dependencies: [fftw_dep],
  install: true,
  install_dir: get_option('bindir'),
)
