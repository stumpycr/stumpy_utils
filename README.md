# Stumpy Utils

A collection of drawing functions for `stumpy_core`, `stumpy_png`, ...

## Usage

### Install the `stumpy_utils` shard

1. `shards init`
2. Add the dependency to the `shard.yml` file
 ``` yaml
 ...
 dependencies:
   stumpy_utils:
     github: stumpycr/stumpy_utils
 ...
 ```
3. `shards install`

You also need to install and require (at least) one of the image extensions
(
[stumpy_png](https://github.com/stumpycr/stumpy_png),
[stumpy_gif](https://github.com/stumpycr/stumpy_gif)
)
or
[stumpy_core](https://github.com/stumpycr/stumpy_core).

## RGBA

### HTML/CSS Color Constants

Adds 148 [HTML Colors](https://www.w3schools.com/colors/colors_names.asp)
to the `RGBA` class.

#### Naming Convention

All uppercase, no seperators. For example:

* AliceBlue => `RGBA::ALICEBLUE`
* Red => `RGBA::RED`

#### Example

``` crystal
require "stumpy_png"
require "stumpy_utils"
include StumpyPNG

canvas = Canvas.new(200, 200) do |x, y|
  case y
  when 0...50
    RGBA::RED
  when 50...100
    RGBA::YELLOW
  when 100...150
    RGBA::GREEN
  else
    RGBA::BLUE
  end
end

StumpyPNG.write(canvas, "colors.png")
```

![Four colored rectangles](examples/colors.png)

### `color1.mix(color2 : RGBA, factor : Float)`

Linear interpolation of two colors,
factor must be in the range of 0.0 (just color1) to 1.0 (just color2).

#### Example

``` crystal
require "stumpy_png"
require "stumpy_utils"
include StumpyPNG

color1 = RGBA::RED
color2 = RGBA::YELLOW

canvas = Canvas.new(400, 50) do |x, y|
  color1.mix(color2, x.to_f / 400)
end

StumpyPNG.write(canvas, "mix.png")
```

![Gradient from red to yellow](examples/mix.png)

## Canvas

### `canvas.line(x0, y0, x1, y1, color = RGBA::BLACK)`

Use the Xiaolin Wo algorithm
to draw an antialiased line from (x0, y0) to (x1, y1).
`x0`, etc can be floats, too.

#### Example

``` crystal
require "stumpy_png"
require "stumpy_utils"
include StumpyPNG

record Branch, x0 : Int32, y0 : Int32, dir : Int32, length : Float64 do
  RADIANTS = Math::PI / 180.0
  FACTOR = (0.6..1.0)
  ANGLE = (30..90)

  def x1; x0 + (Math.sin(dir * RADIANTS) * length).to_i; end
  def y1; y0 + (Math.cos(dir * RADIANTS) * length).to_i; end

  def split
    angle = rand(ANGLE) / 2
    [Branch.new(x1, y1, dir + angle, length * rand(FACTOR)),
     Branch.new(x1, y1, dir - angle, length * rand(FACTOR))]
  end
end

branches = [Branch.new(128, 256, 180, 50.0)]
canvas = Canvas.new(256, 256, RGBA::WHITE)

10.times do |i|
  branches = branches.flat_map do |b|
    canvas.line(b.x0, b.y0, b.x1, b.y1, RGBA::DARKGREEN)
    b.split
  end
end

StumpyPNG.write(canvas, "tree.png")
```

![Tree generated using lines](examples/tree.png)

### `canvas.circle(center_x, center_y, radius, color = RGBA::BLACK, filled = false)`

Use the Xiaolin Wo algorithm
to draw an antialiased (filled) circle
around (center_x, center_y).

#### Example

``` crystal
require "stumpy_png"
require "stumpy_utils"
include StumpyPNG

canvas = Canvas.new(400, 400, RGBA::WHITE)
colors = [RGBA::WHITE, RGBA::DARKSLATEGRAY, RGBA::LIGHTBLUE, RGBA::RED, RGBA::YELLOW]

colors.each_with_index do |color, i|
  radius = (colors.size - i) * 40
  canvas.circle(200, 200, radius, color, true)
end

(colors.size * 2).times do |i|
  radius = ((colors.size * 2) - i) * 20
  canvas.circle(200, 200, radius, RGBA::BLACK, false)
end

StumpyPNG.write(canvas, "circles.png")
```

![Concentric circles](examples/circles.png)
