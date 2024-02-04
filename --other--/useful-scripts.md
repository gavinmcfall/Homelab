# Fix mkv with undefined audio tracks and set to English

```bash
#!/bin/sh
find "${1:-.}" -name \*.mkv | while read file
do
    args=$(mkvmerge --identify --identification-format json "$file" |
        jq '.tracks[] |
        select(.properties.language == "und" and (.type=="audio" or .type=="video")) | (.properties.number)' |
        while read track
        do
          echo "--edit track:$track --set language=eng"
        done)

    if [ "$args" !=  "" ]
    then
        echo $file
        echo mkvpropedit $args "$file"
        mkvpropedit $args "$file"
    fi
done
```