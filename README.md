# raspberry-pi-pico-2

Resources for developing the raspberry-pi-pico-2

You can use the stuff in `riscv-bootstrap` to get started debugging the Pico 2.
It assumes you have a debug probe (or equivalent) and the necessary tools installed and configured. run `make console` to start the gdb server on the debug probe. Then, in a separate terminal window, run `make run` to build and flash the minimal bootstrap program.

## Notes

- I had to build `openocd` from source in order to get the right interfaces/targets for risc-v. I would suggest checking out the [docs/getting-started-with-pico.pdf](docs/getting-started-with-pico) document's section on debugging the rp2350, NOT just the raspberry pi documentation on the debug probe, which is a bit out of date. (not mentioned by the guide, but don't forget to run `sudo make install` after building `openocd`).

- Most of the necessary tools I've either installed via `apt` on Linux Mint or built from the source github repository, however you might also check out the pre-built binaries used by raspberry pi for their vscode extension: https://github.com/raspberrypi/pico-sdk-tools/tags

- If you don't have a debug probe, it's also possible to simply use a second raspberry pi pico running a debugging firmware, see [docs/getting-started-with-pico.pdf](docs/getting-started-with-pico) appendix A.

- Section 2.10 of the [c/c++ sdk documentation](docs/raspberry-pi-pico-c-sdk.pdf) provides useful instructions (and exact configuration options) for building the RISC-V toolchain from source.

- Compiling examples with RISC-V and the pico sdk requires `-DPICO_PLATFROM=rp2350-riscv` (when running `cmake`).

- `bfd len 8 target len 0` --> solved by assembling with `-mabi=ilp32`

- If you do weird things and find your flash is corrupted (and your board is seemingly unresponsive when being flashed with `openocd`), compile a simple program like blinky from [pico-examples](https://github.com/raspberrypi/pico-examples). Instead of using the debug probe, put the board in BOOTSEL mode and load the blinky uf2 like you'd see in the getting-started instructions. This seems to clear up any corrupted state, and you can return to normal development afterwards. 

- I added a function `ic` to `riscv-bootstrap/init.gdb` that increments the program counter before continuing, and now use that instead of `c` in `gdb`.

- If you want to know more about the boot sequence before your defined bootloader is identified/selected/executed, see rp2350 datasheet section 5.2.

- If you poke around the SDK, or disassemble example programs built with the sdk (as I have), you will probably see some writes to addresses that don't map to any registers. These may be offests of a known register to perform an atomic write. For more information, see the rp2350 datasheet section 2.1.3.
- When building and installing `openocd` from source, first install libusb dev: `sudo apt install libusb-1.0-0-dev`
- You will want to add yourself to the dialout group to interface with the debugger:
`sudo usermod -aG dialout $USER`, then log out and log back in


## External Resources

- [Getting Started MicroPython Tutorial](https://projects.raspberrypi.org/en/projects/getting-started-with-the-pico)
- [Pico SDK](https://github.com/raspberrypi/pico-sdk)
- [Pico SDK Tools](https://github.com/raspberrypi/pico-sdk-tools)
- [Pico 2 rp2350 Linker Script](https://github.com/raspberrypi/pico-sdk/blob/master/src/rp2_common/pico_crt0/rp2350/memmap_default.ld)

