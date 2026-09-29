## Architecture & thought process

Writing a custom HAL for this is an overkill & not required at all. Prone to run into compatibility issues. So the approach would be use interfaces and configs within the emulator to use the cam which would be ideal and bugfree and standard.

The demo does not implement a custom Camera HAL or Audio HAL. It reuses the Android Emulator's existing host-device integration in widnows. The host webcam is exposed to the emulator as **webcam0**, while the host microphone is activated through the emulator's **hostmicon** ADB console command.

## Approach

Reuse most available emulator capabilities so that it mostly works with varied types of emulators and configs through standard steps. Less code change and no AOSP change thus making the approach more stable.

**Note:** All bat files were previously steps done manually during debugging. AI was used to create the all BAT files.
          MD files are also generated using AI. Original text without modification is used.
