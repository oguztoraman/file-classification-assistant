#!/bin/bash
#
#  file-classification-assistant.sh
#  
#  Copyright 2020 Oğuz Toraman <oguz.toraman@protonmail.com>
#  
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 3 of the License, or
#  (at your option) any later version.
#  
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#  
#  You should have received a copy of the GNU General Public License
#  along with this program. If not, see <https://www.gnu.org/licenses/>.
#  

echo "File Classification Assistant is starting..."
sleep 1
OLDIFS=$IFS
IFS=$(echo -en "\n\b")
echo "Enter the directory to be classified:"
read -r directory
for i in {Archive,Audio,Codes,Document,Empty,Image,Media,Text,Undetermined}; do
	mkdir -p $directory/Classified\ Files/$i &
done
echo "Files are finding and classifying..."
echo "It may take some time..."
files=$(find $directory -type f | sort)
for i in $files; do
        if [ $(file -b $i | grep -i archive | wc -l) -gt 0 ]; 
        then
                echo $i >> $directory/Classified\ Files/.archive.txt
        elif [ $(file -b $i | grep -i compressed | wc -l) -gt 0 ];
        then
                echo $i >> $directory/Classified\ Files/.archive.txt
        elif [ $(file -b $i | grep -i audio | wc -l) -gt 0 ];
        then
                echo $i >> $directory/Classified\ Files/.audio.txt
        elif [ $(file -b $i | grep -i document | wc -l) -gt 0 ];
        then
                echo $i >> $directory/Classified\ Files/.document.txt
        elif [ $(file -b $i | grep -i htmlhelp | wc -l) -gt 0 ];
        then
                echo $i >> $directory/Classified\ Files/.document.txt
        elif [ $(file -b $i | grep -i image | wc -l) -gt 0 ];
        then
                echo $i >> $directory/Classified\ Files/.image.txt
        elif [ $(file -b $i | grep -i media | wc -l) -gt 0 ];
        then
                echo $i >> $directory/Classified\ Files/.media.txt
        elif [ $(file -b $i | grep -i text | wc -l) -gt 0 ];
        then
                echo $i >> $directory/Classified\ Files/.text.txt
        elif [ $(file -b $i | grep -i microsoft | wc -l) -gt 0 ];
        then
                echo $i >> $directory/Classified\ Files/.text.txt              
        elif [ $(file -b $i | grep -i empty | wc -l) -gt 0 ];
        then
                echo $i >> $directory/Classified\ Files/.empty.txt
        else 
		echo $i >> $directory/Classified\ Files/.undetermined.txt
        fi
done
archive=$(<$directory/Classified\ Files/.archive.txt) && rm -f $directory/Classified\ Files/.archive.txt
audio=$(<$directory/Classified\ Files/.audio.txt) && rm -f $directory/Classified\ Files/.audio.txt
document=$(<$directory/Classified\ Files/.document.txt) && rm -f $directory/Classified\ Files/.document.txt
image=$(<$directory/Classified\ Files/.image.txt) && rm -f $directory/Classified\ Files/.image.txt
media=$(<$directory/Classified\ Files/.media.txt) && rm -f $directory/Classified\ Files/.media.txt
text=$(<$directory/Classified\ Files/.text.txt) && rm -f $directory/Classified\ Files/.text.txt
empty=$(<$directory/Classified\ Files/.empty.txt) && rm -f $directory/Classified\ Files/.empty.txt
undetermined=$(<$directory/Classified\ Files/.undetermined.txt) && rm -f $directory/Classified\ Files/.undetermined.txt
echo "File classification completed!"
echo
echo
echo "Moving Archive files to $directory/Classified\ Files/Archive..."
for i in $archive; do mv -vi $i $directory/Classified\ Files/Archive; done
echo
echo
echo "Moving Audio files to $directory/Classified\ Files/Audio..."
for i in $audio; do mv -vi $i $directory/Classified\ Files/Audio; done
echo
echo
echo "Moving Document files to $directory/Classified\ Files/Document..."
for i in $document; do mv -vi $i $directory/Classified\ Files/Document; done
echo
echo
echo "Moving Image files to $directory/Classified\ Files/Image..."
for i in $image; do mv -vi $i $directory/Classified\ Files/Image; done
echo
echo
echo "Moving Media files to $directory/Classified\ Files/Media..."
for i in $media; do mv -vi $i $directory/Classified\ Files/Media; done
echo
echo
echo "Moving Text files to $directory/Classified\ Files/Text..."
for i in $text; do mv -vi $i $directory/Classified\ Files/Text; done
echo
echo
echo "Source Code files are finding and classifying..."
echo "It may take some time..."
files=$(find $directory/Classified\ Files/Text -type f | sort)
for i in $files; do
        if [ $(file -b $i | grep -i source | wc -l) -gt 0 ]; 
        then
                echo $i >> $directory/Classified\ Files/.code.txt
        elif [ $(file -b $i | grep -i script | wc -l) -gt 0 ];
        then
		echo $i >> $directory/Classified\ Files/.code.txt
	fi
done
code=$(<$directory/Classified\ Files/.code.txt) && rm -f $directory/Classified\ Files/.code.txt
echo "Moving Source Code files to $directory/Classified\ Files/Codes..."
for i in $code; do mv -vi $i $directory/Classified\ Files/Codes; done
echo
echo
echo "Moving Empty files to $directory/Classified\ Files/Empty..."
for i in $empty; do mv -vi $i $directory/Classified\ Files/Empty; done
echo
echo
echo "Moving Undetermined files to $directory/Classified\ Files/Undetermined..."
for i in $undetermined; do mv -vi $i $directory/Classified\ Files/Undetermined; done
echo
echo
echo "Done!"
IFS=$SAVEIFS
exit
