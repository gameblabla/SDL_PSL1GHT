CC = $(PS3DEV)/ppu/bin/powerpc64-ps3-elf-gcc
AR = $(PS3DEV)/ppu/bin/powerpc64-ps3-elf-ar
RANLIB = $(PS3DEV)/ppu/bin/powerpc64-ps3-elf-ranlib
STRIP = $(PS3DEV)/ppu/bin/powerpc64-ps3-elf-strip

INCLUDE = -I include
CFLAGS = -Wall -Wextra -O2 -flto -Wno-unused-parameter
CFLAGS += -mcpu=cell  -I$(PS3DEV)/portlibs/ppu/include/SDL -I$(PS3DEV)/portlibs/ppu/include
CFLAGS += -maltivec -DHAVE_STDINT_H -D_STDINT_H_ -D__PSL1GHT__ -DHAVE_POW -DHAVE_MMAP=0 -DDEBUG_ERROR

TARGET = libSDL.a
CONFIG_H = include/SDL_config.h
SOURCES = \
	src/SDL.c \
	src/SDL_assert.c \
	src/SDL_compat.c \
	src/SDL_error.c \
	src/SDL_fatal.c \
	src/SDL_hints.c \
	src/SDL_log.c \
	src/atomic/SDL_atomic.c \
	src/atomic/SDL_spinlock.c \
	src/audio/SDL_audio.c \
	src/audio/SDL_audiocvt.c \
	src/audio/SDL_audiodev.c \
	src/audio/SDL_audiotypecvt.c \
	src/audio/SDL_mixer.c \
	src/audio/SDL_wave.c \
	src/cpuinfo/SDL_cpuinfo.c \
	src/events/SDL_clipboardevents.c \
	src/events/SDL_events.c \
	src/events/SDL_gesture.c \
	src/events/SDL_keyboard.c \
	src/events/SDL_mouse.c \
	src/events/SDL_quit.c \
	src/events/SDL_touch.c \
	src/events/SDL_windowevents.c \
	src/file/SDL_rwops.c \
	src/render/SDL_render.c \
	src/render/SDL_yuv_mmx.c \
	src/render/SDL_yuv_sw.c \
	src/render/direct3d/SDL_render_d3d.c \
	src/render/nds/SDL_ndsrender.c \
	src/render/opengl/SDL_render_gl.c \
	src/render/opengl/SDL_shaders_gl.c \
	src/render/opengles/SDL_render_gles.c \
	src/render/opengles2/SDL_render_gles2.c \
	src/render/opengles2/SDL_shaders_gles2.c \
	src/render/psl1ght/SDL_PSL1GHTrender.c \
	src/render/software/SDL_blendfillrect.c \
	src/render/software/SDL_blendline.c \
	src/render/software/SDL_blendpoint.c \
	src/render/software/SDL_drawline.c \
	src/render/software/SDL_drawpoint.c \
	src/render/software/SDL_render_sw.c \
	src/stdlib/SDL_getenv.c \
	src/stdlib/SDL_iconv.c \
	src/stdlib/SDL_malloc.c \
	src/stdlib/SDL_qsort.c \
	src/stdlib/SDL_stdlib.c \
	src/stdlib/SDL_string.c \
	src/thread/SDL_thread.c \
	src/timer/SDL_timer.c \
	src/video/SDL_RLEaccel.c \
	src/video/SDL_blit.c \
	src/video/SDL_blit_0.c \
	src/video/SDL_blit_1.c \
	src/video/SDL_blit_A.c \
	src/video/SDL_blit_N.c \
	src/video/SDL_blit_auto.c \
	src/video/SDL_blit_copy.c \
	src/video/SDL_blit_slow.c \
	src/video/SDL_bmp.c \
	src/video/SDL_clipboard.c \
	src/video/SDL_fillrect.c \
	src/video/SDL_pixels.c \
	src/video/SDL_rect.c \
	src/video/SDL_shape.c \
	src/video/SDL_stretch.c \
	src/video/SDL_surface.c \
	src/video/SDL_video.c \
	src/joystick/SDL_joystick.c \
	src/haptic/SDL_haptic.c \
	src/power/SDL_power.c \
	src/video/psl1ght/SDL_PSL1GHTevents.c \
	src/video/psl1ght/SDL_PSL1GHTkeyboard.c \
	src/video/psl1ght/SDL_PSL1GHTmodes.c \
	src/video/psl1ght/SDL_PSL1GHTmouse.c \
	src/video/psl1ght/SDL_PSL1GHTvideo.c \
	src/thread/psl1ght/SDL_syssem.c \
	src/thread/psl1ght/SDL_systhread.c \
	src/thread/generic/SDL_sysmutex.c \
	src/thread/generic/SDL_syscond.c \
	src/joystick/psl1ght/SDL_sysjoystick.c \
	src/timer/psl1ght/SDL_systimer.c \
	src/audio/psl1ght/SDL_psl1ghtaudio.c \
	src/haptic/dummy/SDL_syshaptic.c \
	src/loadso/dummy/SDL_sysloadso.c \
	src/main/dummy/SDL_dummy_main.c
OBJECTS = $(SOURCES:.c=.o)


all: $(TARGET)

$(TARGET): $(OBJECTS)
	$(AR) cr $@ $^
	$(RANLIB) $@
	$(STRIP) --strip-unneeded $@

.c.o:
	$(CC) $(INCLUDE) $(CFLAGS) -c $< -o $@
	
install:
	cp $(TARGET) $(PS3DEV)/portlibs/ppu/lib/$(TARGET)
	cp -r include /tmp
	mv /tmp/include /tmp/SDL
	cp -r /tmp/SDL $(PS3DEV)/portlibs/ppu/include
	rm -r /tmp/SDL
	
clean:
	rm -f $(OBJECTS) $(TARGET)
