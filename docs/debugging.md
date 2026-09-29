# Webcam & Laptop Mic Setup for Android Emulator Calls

## Summary
Set up the Android emulator so a call uses the laptop **webcam as the front camera** and the **laptop mic as the primary mic**. The approach reuses existing emulator capabilities (config values, command-line flags, and the emulator console) rather than building anything custom.

## What Is Implemented
- Steps to set config values so the **webcam is the front camera**.
- Steps to launch the emulator with `-allow-host-audio` so the **laptop mic** is used.
- A check that the emulator's `hostmicon` state is OK, using the `adb emu avd` command group. This check is also included in the BAT script.
- End-to-end emulator setup for calls: webcam as front cam, laptop mic as primary mic.

## What Was Reused
- Emulator command-line options (`-camera-front`, `-camera-back`, `-allow-host-audio`).
- The emulator's AVD config file.
- The emulator console (`adb emu avd ...`) for inspecting the state of a running emulator.

## Approach / Debugging

**Step 1: Laptop 1, camera via emulator settings**
- Set both front cam and back cam to `webcam0` through the emulator settings.
- Result: the camera app crashed (crash logs are in `root/logs/`).

```
09-28 09:33:11.409  5094  5094 E AndroidRuntime:  ... 14 more
09-28 09:33:11.410   737  3066 I am_crash: [5094,0,com.android.camera2,819706949,java.lang.ArrayIndexOutOfBoundsException,length=1; index=1,AndroidCameraAgentImpl.java,176,0]
```

- **Root cause:** only one camera was registered, but the camera app looks for a second one, hence `ArrayIndexOutOfBoundsException: length=1; index=1`.
- **Fix:** assign only one camera to the webcam in the config, or launch directly with:

```
emulator -avd Medium_Phone -camera-front webcam0 -camera-back emulated
```

**Step 2: Laptop 2, suspected compatibility issue**
- Assumed a camera resolution/compatibility mismatch on Laptop 1 and moved to Laptop 2 without checking the logs first. This did not help. The logs later revealed the actual problem (Step 1).

**Step 3: Laptop 2, exploring the emulator directly**
- Explored how emulator commands work and how groups are exposed via `adb emu avd <group>`.
- Used this to identify the `hostmicon` property.

**Step 4: Laptop 2, camera setup via command line and config**
- Did the whole setup from the command line and modified the camera config, with nothing set through the emulator UI settings.
- Result: the camera started working in the Camera app (it had crashed before).

**Step 5: Microphone**
- The mic was still not working.
- Inspected the config file and found only `hw.audioInput=yes` and nothing else related to audio.
- Found the `-allow-host-audio` option and tried it.
- Launched the emulator with `-allow-host-audio`, then checked `hostmicon` via `adb emu avd`. It reported **OK** (this check is also in the BAT script).
- Result: the mic worked when tested in calls.

## Limitations
- **Linux:** the webcam/camera architecture may differ, since Linux exposes hardware as devices under `/dev/...`. This approach may not work directly there, and the device mapping would need to be reworked.
- **Emulator commands:** the emulator command set needs further exploration to cover other cases.

## Supporting a Remotely Hosted Android Device
- An environment variable change (for example, pointing the scripts at the remote device or emulator target) should be enough for this approach to work.