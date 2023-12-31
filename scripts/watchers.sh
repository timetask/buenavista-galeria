#!/bin/bash
watcher="watchexec"
project_dir=`pwd`
assets_dir="${project_dir}/lib/assets"
static_dir="${project_dir}/priv/static"

themes_dir="${project_dir}/lib/themes"
components_dir="${project_dir}/lib/components"

esbuild_config="--bundle"

pids=()
child_themes=(light dark)

# Listen to component changes
$watcher -w $components_dir/ -e ex \
  "mix galeria.gen.internal.themes --theme base" \
  &
pids+=("$!")

# Listen to base hydrator changes
$watcher -p -w $themes_dir/base/buenavista_galeria_hydrator.ex \
  "mix galeria.gen.internal.themes --theme light --theme dark" \
  &
pids+=("$!")

# Listen to child theme hydrators changes
for theme in "${child_themes[@]}"; 
do
  $watcher -p -w $themes_dir/$theme/buenavista_galeria_hydrator.ex \
    "mix galeria.gen.internal.css --theme $theme;
    esbuild $assets_dir/themes/$theme.css --outdir=$static_dir/themes $esbuild_config" \
    &
  pids+=("$!")
done

# Listen to css changes
$watcher -p -w $assets_dir/css/ -e css \
  esbuild $assets_dir/css/galeria.css --outdir=$static_dir/css $esbuild_config \
  &
pids+=("$!")

# Listen to js changes
$watcher -w $assets_dir/js/ -e js \
  esbuild $assets_dir/js/galeria.js --outdir=$static_dir/js $esbuild_config \
  &
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

