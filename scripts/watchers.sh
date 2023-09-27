#!/bin/bash
watcher="watchexec"
project_dir=`pwd`
assets_dir="${project_dir}/lib/assets"
static_dir="${project_dir}/priv/static"

config_dir="${project_dir}/lib/config"
components_dir="${project_dir}/lib/components"

esbuild_config="--bundle"

pids=()

# Listen to component changes
$watcher --watch=$components_dir/ -r -e ex "mix galeria.gen.config; mix format" &
pids+=("$!")

# Listen to base hydrator changes
$watcher --watch=$config_dir/base_hydrator.ex \
  "mix galeria.gen.config --theme light --theme dark;
  mix format" \
  &
    
# Listen to theme hydrators changes
$watcher --watch=$config_dir/light_hydrator.ex \
  "mix galeria.gen.css --theme light;
  mix format;
  esbuild $assets_dir/themes/light.css --outdir=$static_dir/themes $esbuild_config" \
  &
pids+=("$!")

$watcher --watch=$config_dir/dark_hydrator.ex \
  "mix galeria.gen.css --theme dark; 
  mix format; 
  esbuild $assets_dir/themes/dark.css --outdir=$static_dir/themes $esbuild_config" \
  &
pids+=("$!")

# Listen to css changes
$watcher --watch=$assets_dir/css/ -r -e css \
  esbuild $assets_dir/css/galeria.css --outdir=$static_dir/css $esbuild_config &
pids+=("$!")

# Listen to js changes
$watcher --watch=$assets_dir/js/ -r -e js \
  esbuild $assets_dir/js/galeria.js --outdir=$static_dir/js $esbuild_config &
pids+=("$!")

echo "Press Ctrl-C to stop all watchers"

function kill_all() {
  for pid in "${pids[@]}" 
  do
    kill -9 $pid
  done

  exit
}

trap kill_all INT

while true 
do
 sleep 2
done

