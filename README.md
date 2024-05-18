Enhance your Flutter asset handling with `to_png`! This package leverages the new Flutter feature, [asset transformation](https://docs.flutter.dev/ui/assets/asset-transformation), to convert vector formats into PNG format. Designed to provide developers with more control and accuracy in rendering assets, `to_png` ensures your visuals look sharp and consistent across all devices! 🚀🖼️

## Why `to_png`?

- **Reliability**: Direct vector (SVG/PDF) rendering can lead to inconsistencies. `to_png` ensures what you design is what you display.
- **Ease of Use**: Simple setup and configuration directly within your `pubspec.yaml`.

## Installation
Add `to_png` to your dev_dependencies inside `pubspec.yaml` file:
```yaml
dev_dependencies:
  to_png: latest_version
```

## Supported Formats

| Format | Supported | Tool Used    |
|--------|-----------|--------------|
| SVG    | ✅       | [svgexport](https://www.npmjs.com/package/svgexport)    |
| PDF    | ✅       | Built-in [PDFium](https://pdfium.googlesource.com/pdfium/) |

## Usage

```yaml
  assets:
    - path: assets/logo.svg
      transformers:
        - package: to_png
```

## FAQ

**Q: What scale should I use?**  
A: The scale depends on your needs. The default is `1`, but you can increase it to enhance the image size and detail for high-resolution displays.

```yaml
  assets:
    - path: assets/logo.svg
      transformers:
        - package: to_png
          args: ['--scale=3']
```

**Q: How do I install svgexport?**  
A: `svgexport` is used to convert `svg` to `png` so if you wish to convert svgs you should install `svgexport` by running `npm install -g svgexport` in your terminal after installing Node.js and npm.

**Q: Can I convert assets in real-time during development?**  
A: Yes, `to_png` works during the build process, automatically converting specified assets as part of your development workflow.

**Q: How can I use the result?**  
A: you can use it as any png image, just remember that the name(extension included) will not change. So if you apply the package on `logo.svg` image, you can use it within an `Image` widget:
```dart
Image.asset("assets/logo.svg")
```

## Contributing

Feel free to contribute to the development of `to_png` by submitting pull requests or issues on our GitHub repository [here](https://github.com/hadysata/to_png/tree/main/src).