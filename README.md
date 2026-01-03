##

- flutter create tiktok_challenge
- https://mobbin.com/ - UI Kits

- https://fontawesome.com/ - Icons
- https://pub.dev/packages/font_awesome_flutter - Installation
- flutter pub get
- https://nomadcoders.co/c/tiktok-challenge/lobby

## android device record
```bash
adb shell screenrecord --time-limit 160 --size 1280x720 --bit-rate 6000000 /sdcard/test.mp4
adb pull /sdcard/test.mp4 .
```
## mp4 to gif
```bash
ffmpeg -i test.mp4 \
  -filter_complex "fps=10,scale=1280:720:flags=lanczos,split[a][b];[a]palettegen=max_colors=256[p];[b][p]paletteuse=dither=bayer" \
  -loop 0 test.gif
```