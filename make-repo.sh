#!/bin/sh
set -eu

clean_worktree_and_index() (
	repo="$1"
	shift
	printf "Clean working tree and index of %s\n" "${repo}"
	git -C "${repo}" clean -x --force --quiet
	git -C "${repo}" rm -r --force --quiet :/
)

create_commit() (
	repo="$1"
	shift
	flag_d=
	flag_m=
	flag_a=
	date=
	comment=
	archive_args=
	while getopts a:d:m: name ; do
		case $name in
			a)
				flag_a=1
				archive_args="$OPTARG"
				;;
			d)
				flag_d=1
				date="$OPTARG"
				;;
			m)
				flag_m=1
				comment="$OPTARG"
				;;
			?)
				exit 2
				;;
		esac
	done
	if [ -z "$flag_m" ] ; then
		printf "Option -m is mandatory\n" >&2
		exit 2
	fi
	shift $(($OPTIND - 1))
	source_path="$1"
	shift
	printf "Create commit for %s at %s\n" "${source_path}" "${repo}"
	(
		if [ -n "$flag_d" ] ; then
			printf "Set date to %s\n" "${date}"
			export GIT_AUTHOR_DATE="${date}"
			export GIT_COMMITTER_DATE="${date}"
		fi
		(
			cd "${repo}"
			case "${source_path}" in
				*.tar.bz2)
					tar -x -f "${source_path}" ${archive_args}
					;;
				*.zip)
					unzip -q "${source_path}" ${archive_args} && true
					ret=$?
					if [ "$ret" != 0 ] && [ "$ret" != 1 ] ; then
						exit "$ret"
					fi
					;;
				*)
					exit 1
					;;
			esac
		)
		git -C "${repo}" add :/
		printf "Comment is: %s\n" "${comment}"
		git -C "${repo}" commit -m "${comment}"
	)
)

workdir_path="workdir"

# Create a working directory
mkdir "${workdir_path}"

# Configures git
export GIT_AUTHOR_NAME="MCP Team"
export GIT_AUTHOR_EMAIL="mcp@ocean-labs.de"
export GIT_AUTHOR_DATE="1970-01-01T00:00:00.000Z"
export GIT_COMMITTER_NAME="MCP Team"
export GIT_COMMITTER_EMAIL="mcp@ocean-labs.de"
export GIT_COMMITTER_DATE="1970-01-01T00:00:00.000Z"

# Initialize the repository
git -C "${workdir_path}" init .
touch "${workdir_path}"/remove_me
git -C "${workdir_path}" add remove_me
clean_worktree_and_index "${workdir_path}"
git -C "${workdir_path}" switch main

# Commit version 1.0
create_commit "${workdir_path}" -d "2010-10-17T01:22:37Z" -m "v1.0 downloaded from https://www.mediafire.com/?nukc5jh5yu83cdp" "${SOURCES_DIRECTORY}/revengpack.zip"

# Reset the working tree and the index
clean_worktree_and_index "${workdir_path}"

# Commit version 1.1
create_commit "${workdir_path}" -d "2010-10-17T12:51:36Z" -m "v1.1 downloaded from https://www.mediafire.com/?4ygvy942rsecjw7" "${SOURCES_DIRECTORY}/revengpack11.zip"

# Reset the working tree and the index
clean_worktree_and_index "${workdir_path}"

# Commit version 1.2
create_commit "${workdir_path}" -d "2010-10-18T18:24:19Z" -m "v1.2 downloaded from https://www.mediafire.com/?sumc56jz5su8546" "${SOURCES_DIRECTORY}/revengpack12.zip"

# Reset the working tree and the index
clean_worktree_and_index "${workdir_path}"

# Commit version 1.3
create_commit "${workdir_path}" -d "2010-10-20T16:30:19Z" -m "v1.3 downloaded from https://www.mediafire.com/?44s3710ah5f078j" "${SOURCES_DIRECTORY}/revengpack13.zip"

# Reset the working tree and the index
clean_worktree_and_index "${workdir_path}"

# Commit version 1.4
create_commit "${workdir_path}" -d "2010-10-22T18:20:26Z" -m "v1.4 downloaded from https://www.mediafire.com/?i44y3sp66e6ag62" "${SOURCES_DIRECTORY}/revengpack14.zip"

# Reset the working tree and the index
clean_worktree_and_index "${workdir_path}"

# Commit version 1.5
create_commit "${workdir_path}" -d "2010-10-23T09:22:54Z" -m "v1.5 downloaded from https://www.mediafire.com/?777ifteu05j2m6b" "${SOURCES_DIRECTORY}/revengpack15.zip"

# Reset the working tree and the index
clean_worktree_and_index "${workdir_path}"

# Commit version 1.6
create_commit "${workdir_path}" -d "2010-10-28T18:24:37Z" -m "v1.6 downloaded from https://www.mediafire.com/?7gq62gydrb12c2a" "${SOURCES_DIRECTORY}/revengpack16.zip"

# Reset the working tree and the index
clean_worktree_and_index "${workdir_path}"

# Commit version 2.0
create_commit "${workdir_path}" -d "2010-11-06T18:23:38Z" -m "v2.0 downloaded from https://www.mediafire.com/?0bmbq333sobp44h" "${SOURCES_DIRECTORY}/mcp20.zip"

# Reset the working tree and the index
clean_worktree_and_index "${workdir_path}"

# Commit version 2.0a
create_commit "${workdir_path}" -d "2010-11-06T19:23:12Z" -m "v2.0a downloaded from https://www.mediafire.com/?xmllq6u6zsgc0k8" "${SOURCES_DIRECTORY}/mcp20a.zip"

# Reset the working tree and the index
clean_worktree_and_index "${workdir_path}"

# Commit version 2.1
create_commit "${workdir_path}" -d "2010-11-10T19:34:07Z" -m "v2.1 downloaded from https://www.mediafire.com/?ym16233j5901bo4" "${SOURCES_DIRECTORY}/mcp21.zip"

# Reset the working tree and the index
clean_worktree_and_index "${workdir_path}"

# Commit version 2.2
create_commit "${workdir_path}" -d "2010-11-16T16:55:04Z" -m "v2.2 downloaded from https://www.mediafire.com/?fp1xw3u9i9yo0bl" "${SOURCES_DIRECTORY}/mcp22.zip"

# Reset the working tree and the index
clean_worktree_and_index "${workdir_path}"

# Commit version 2.2a
create_commit "${workdir_path}" -d "2010-11-17T16:15:41Z" -m "v2.2a downloaded from https://www.mediafire.com/?vwgj80p8n1plrlq" "${SOURCES_DIRECTORY}/mcp22a.zip"

# Reset the working tree and the index
clean_worktree_and_index "${workdir_path}"

# Commit version 2.3
create_commit "${workdir_path}" -d "2010-11-26T21:14:35Z" -m "v2.3 downloaded from https://www.mediafire.com/?12jdmiqkd5gy977" "${SOURCES_DIRECTORY}/mcp23.zip"

# Reset the working tree and the index
clean_worktree_and_index "${workdir_path}"

# Commit version 2.4
create_commit "${workdir_path}" -d "2010-12-02T17:31:05Z" -m "v2.4 downloaded from https://www.mediafire.com/?o7ddvw1o65g3wj3" "${SOURCES_DIRECTORY}/mcp24.zip"

# Reset the working tree and the index
clean_worktree_and_index "${workdir_path}"

# Commit version 2.5
create_commit "${workdir_path}" -d "2010-12-03T19:05:28Z" -m "v2.5 downloaded from https://www.mediafire.com/?7422b88qu650547" "${SOURCES_DIRECTORY}/mcp25.zip"

# Reset the working tree and the index
clean_worktree_and_index "${workdir_path}"

# Commit version 2.6
create_commit "${workdir_path}" -d "2011-01-13T17:45:13Z" -m "v2.6 downloaded from https://www.mediafire.com/?cjrw785u9e857yh" "${SOURCES_DIRECTORY}/mcp26.zip"

# Reset the working tree and the index
clean_worktree_and_index "${workdir_path}"

# Commit version 2.7
create_commit "${workdir_path}" -d "2011-01-24T06:05:39Z" -m "v2.7 downloaded from https://www.mediafire.com/?k3sev7pdlreou4j" "${SOURCES_DIRECTORY}/mcp27.zip"

# Reset the working tree and the index
clean_worktree_and_index "${workdir_path}"

# Commit version 2.8
create_commit "${workdir_path}" -d "2011-02-15T16:24:56Z" -m "v2.8 downloaded from https://www.mediafire.com/?0d6iby6se4h7aam" "${SOURCES_DIRECTORY}/mcp28.zip"

# Reset the working tree and the index
clean_worktree_and_index "${workdir_path}"

# Commit version 2.9
create_commit "${workdir_path}" -d "2011-02-25T10:32:18Z" -m "v2.9 downloaded from https://www.mediafire.com/?5coxcq54s9qn6m9" "${SOURCES_DIRECTORY}/mcp29.zip"

# Reset the working tree and the index
clean_worktree_and_index "${workdir_path}"

# Commit version 2.9a
create_commit "${workdir_path}" -d "2011-02-26T13:51:20Z" -m "v2.9a downloaded from https://www.mediafire.com/?idlmki22diklhf3" "${SOURCES_DIRECTORY}/mcp29a.zip"

# Reset the working tree and the index
clean_worktree_and_index "${workdir_path}"

# Commit version 2.10
create_commit "${workdir_path}" -d "2011-04-01T17:40:39Z" -m "v2.10 downloaded from https://www.mediafire.com/?v8jr2vo524yaqnn" "${SOURCES_DIRECTORY}/mcp210.zip"

# Reset the working tree and the index
clean_worktree_and_index "${workdir_path}"

# Commit version 2.11
create_commit "${workdir_path}" -d "2011-04-05T12:12:43Z" -m "v2.11 downloaded from https://www.mediafire.com/?skko90kp657q6kb" "${SOURCES_DIRECTORY}/mcp211.zip"

# Reset the working tree and the index
clean_worktree_and_index "${workdir_path}"

# Commit version 2.12
create_commit "${workdir_path}" -d "2011-04-28T22:09:55Z" -m "v2.12 downloaded from https://www.mediafire.com/?p5ptl7epbuk5emy" "${SOURCES_DIRECTORY}/mcp212.zip"

# Reset the working tree and the index
clean_worktree_and_index "${workdir_path}"

# Commit version 3.0
create_commit "${workdir_path}" -d "2011-04-13T18:05:38Z" -m "v3.0 downloaded from https://www.mediafire.com/?793j36x8r1an3bz" "${SOURCES_DIRECTORY}/mcp30.zip"

# Reset the working tree and the index
clean_worktree_and_index "${workdir_path}"

# Commit version 3.1
create_commit "${workdir_path}" -d "2011-04-29T12:59:35Z" -m "v3.1 downloaded from https://www.mediafire.com/?2gskj39vdafepri" "${SOURCES_DIRECTORY}/mcp31.zip"

# Reset the working tree and the index
clean_worktree_and_index "${workdir_path}"

# Commit version 3.2
create_commit "${workdir_path}" -d "2011-05-27T19:06:34Z" -m "v3.2 downloaded from https://www.mediafire.com/?x2otccwnqbmusjg" "${SOURCES_DIRECTORY}/mcp32.zip"

# Reset the working tree and the index
clean_worktree_and_index "${workdir_path}"

# Commit version 3.3
create_commit "${workdir_path}" -d "2011-05-28T20:08:27Z" -m "v3.3 downloaded from https://www.mediafire.com/?kwkk3l008g6bft1" "${SOURCES_DIRECTORY}/mcp33.zip"

# Reset the working tree and the index
clean_worktree_and_index "${workdir_path}"

# Commit version 3.4
create_commit "${workdir_path}" -d "2011-05-31T09:05:18Z" -m "v3.4 downloaded from https://www.mediafire.com/?gbciib2sgukgtb7" "${SOURCES_DIRECTORY}/mcp34.zip"

# Reset the working tree and the index
clean_worktree_and_index "${workdir_path}"

# Commit version 4.0
create_commit "${workdir_path}" -d "2011-05-31T17:30:57Z" -m "v4.0 downloaded from https://www.mediafire.com/?5pn4dawl1f7b55d" "${SOURCES_DIRECTORY}/mcp40.zip"

# Reset the working tree and the index
clean_worktree_and_index "${workdir_path}"

# Commit version 4.1
create_commit "${workdir_path}" -d "2011-06-05T12:59:23Z" -m "v4.1 downloaded from https://www.mediafire.com/?tgftx5b6u43lcpm" "${SOURCES_DIRECTORY}/mcp41.zip"

# Reset the working tree and the index
clean_worktree_and_index "${workdir_path}"

# Commit version 4.2
create_commit "${workdir_path}" -d "2011-07-05T12:55:37Z" -m "v4.2 downloaded from https://www.mediafire.com/?1gtxx92yrrbt2cx" "${SOURCES_DIRECTORY}/mcp42.zip"

# Reset the working tree and the index
clean_worktree_and_index "${workdir_path}"

# Commit version 4.3
create_commit "${workdir_path}" -d "2011-07-08T07:56:51Z" -m "v4.3 downloaded from https://www.mediafire.com/?03d94f13c9ulj5a" "${SOURCES_DIRECTORY}/mcp43.zip"

# Reset the working tree and the index
clean_worktree_and_index "${workdir_path}"

# Commit version 4.4
create_commit "${workdir_path}" -d "2011-09-18T09:34:24Z" -m "v4.4 downloaded from https://www.mediafire.com/?g09as6o73ls77c6" "${SOURCES_DIRECTORY}/mcp44.zip"

# Reset the working tree and the index
clean_worktree_and_index "${workdir_path}"

# Commit version 4.5pre
create_commit "${workdir_path}" -d "2011-11-02T11:43:57Z" -m "v4.5pre downloaded from https://www.mediafire.com/?rf5tothc5h7au3f" "${SOURCES_DIRECTORY}/mcp45pre.zip"

# Reset the working tree and the index
clean_worktree_and_index "${workdir_path}"

# Commit version 5.0
create_commit "${workdir_path}" -d "2011-11-24T19:15:32Z" -m "v5.0 downloaded from https://www.mediafire.com/?s7dyeugk867no9j" "${SOURCES_DIRECTORY}/mcp50.zip"

# Reset the working tree and the index
clean_worktree_and_index "${workdir_path}"

# Commit version 5.6
create_commit "${workdir_path}" -d "2012-01-13T21:43:37Z" -m "v5.6 downloaded from https://www.mediafire.com/?wu9gfhy73m4k6a4" "${SOURCES_DIRECTORY}/mcp56.zip"

# Reset the working tree and the index
clean_worktree_and_index "${workdir_path}"

# Commit version 6.0
create_commit "${workdir_path}" -d "2012-03-03T07:05:29Z" -m "v6.0 downloaded from https://www.mediafire.com/?emz17agmzr3ed7e" "${SOURCES_DIRECTORY}/mcp60.zip"

# Reset the working tree and the index
clean_worktree_and_index "${workdir_path}"

# Commit version 6.1
create_commit "${workdir_path}" -d "2012-03-24T07:37:03Z" -m "v6.1 downloaded from https://www.mediafire.com/?hl1t281w442wfxf" "${SOURCES_DIRECTORY}/mcp61.zip"

# Reset the working tree and the index
clean_worktree_and_index "${workdir_path}"

# Commit version 6.2
create_commit "${workdir_path}" -d "2012-03-30T17:53:12Z" -m "v6.2 downloaded from https://www.mediafire.com/?c6liau295225253" "${SOURCES_DIRECTORY}/mcp62.zip"

# Reset the working tree and the index
clean_worktree_and_index "${workdir_path}"

# Commit version 6.5
create_commit "${workdir_path}" -d "2012-04-30T23:58:11Z" -m "v6.5 downloaded from https://www.mediafire.com/?0nxeeitb1s54x1e" "${SOURCES_DIRECTORY}/mcp65.zip"

# Reset the working tree and the index
clean_worktree_and_index "${workdir_path}"

# Commit version 6.15
create_commit "${workdir_path}" -d "2012-07-01T07:48:05Z" -m "v6.15 downloaded from https://www.mediafire.com/?dhhvhzezje6zx59" "${SOURCES_DIRECTORY}/mcp615.zip"

# Reset the working tree and the index
clean_worktree_and_index "${workdir_path}"

# Commit version 7.0
create_commit "${workdir_path}" -d "2012-08-01T11:10:18Z" -m "v7.0 downloaded from https://www.mediafire.com/?chw6hym6lu974xn" "${SOURCES_DIRECTORY}/mcp70.zip"

# Reset the working tree and the index
clean_worktree_and_index "${workdir_path}"

# Commit version 7.0a
create_commit "${workdir_path}" -d "2012-08-03T14:48:57Z" -m "v7.0a downloaded from https://www.mediafire.com/?hxui27dv5q4k8v4" "${SOURCES_DIRECTORY}/mcp70a.zip"

# Reset the working tree and the index
clean_worktree_and_index "${workdir_path}"

# Commit version 7.2
create_commit "${workdir_path}" -d "2012-08-15T11:32:57Z" -m "v7.2 downloaded from https://www.mediafire.com/?38vjh7hrpprrw1b" "${SOURCES_DIRECTORY}/mcp72.zip"

# Reset the working tree and the index
clean_worktree_and_index "${workdir_path}"

# Commit version 7.19
create_commit "${workdir_path}" -d "2012-10-25T06:40:07Z" -m "v7.19 downloaded from https://www.mediafire.com/?rz8dnqj1bxrz85q" "${SOURCES_DIRECTORY}/mcp719.zip"

# Reset the working tree and the index
clean_worktree_and_index "${workdir_path}"

# Commit version 7.21
create_commit "${workdir_path}" -d "2012-11-08T16:57:13Z" -m "v7.21 downloaded from https://www.mediafire.com/?i27oi6miadssyp9" "${SOURCES_DIRECTORY}/mcp721.zip"

# Reset the working tree and the index
clean_worktree_and_index "${workdir_path}"

# Commit version 7.23
create_commit "${workdir_path}" -d "2012-11-19T16:28:21Z" -m "v7.23 downloaded from https://www.mediafire.com/?spaiyzpccxkx6cg" "${SOURCES_DIRECTORY}/mcp723.zip"

# Reset the working tree and the index
clean_worktree_and_index "${workdir_path}"

# Commit version 7.25
create_commit "${workdir_path}" -d "2012-12-20T05:18:42Z" -m "v7.25 downloaded from https://www.mediafire.com/?4kzs5swcm5ypqo6" "${SOURCES_DIRECTORY}/mcp725.zip"

# Reset the working tree and the index
clean_worktree_and_index "${workdir_path}"

# Commit version 7.26a
create_commit "${workdir_path}" -d "2013-01-13T16:18:29Z" -m "v7.26a downloaded from https://www.mediafire.com/?07d59w314ewjfth" "${SOURCES_DIRECTORY}/mcp726a.zip"

# Reset the working tree and the index
clean_worktree_and_index "${workdir_path}"

# Commit version 7.30c
create_commit "${workdir_path}" -d "2013-01-13T18:02:35Z" -m "v7.30c downloaded from https://www.mediafire.com/?8amwnl6gt6p6gc5" "${SOURCES_DIRECTORY}/mcp730c.zip"

# Reset the working tree and the index
clean_worktree_and_index "${workdir_path}"

# Commit version 7.34
create_commit "${workdir_path}" -d "2013-02-01T21:04:28Z" -m "v7.34 downloaded from https://www.mediafire.com/?690vfbejvfe8q0m" "${SOURCES_DIRECTORY}/mcp734.zip"

# Reset the working tree and the index
clean_worktree_and_index "${workdir_path}"

# Commit version 7.39
create_commit "${workdir_path}" -d "2013-03-02T09:58:22Z" -m "v7.39 downloaded from https://www.mediafire.com/?t23e247mudahtam" "${SOURCES_DIRECTORY}/mcp739.zip"

# Reset the working tree and the index
clean_worktree_and_index "${workdir_path}"

# Commit version 7.42
create_commit "${workdir_path}" -d "2013-03-12T16:14:46Z" -m "v7.42 downloaded from https://www.mediafire.com/?bbgk21dw4mp02sp" "${SOURCES_DIRECTORY}/mcp742.zip"

# Reset the working tree and the index
clean_worktree_and_index "${workdir_path}"

# Commit version 7.44
create_commit "${workdir_path}" -d "2013-03-20T04:40:01Z" -m "v7.44 downloaded from https://www.mediafire.com/?2s29h4469m2ysao" "${SOURCES_DIRECTORY}/mcp744.zip"

# Reset the working tree and the index
clean_worktree_and_index "${workdir_path}"

# Commit version 7.51
create_commit "${workdir_path}" -d "2013-04-27T06:35:42Z" -m "v7.51 downloaded from https://www.mediafire.com/?95vlzp1a4n4wjqw" "${SOURCES_DIRECTORY}/mcp751.zip"

# Reset the working tree and the index
clean_worktree_and_index "${workdir_path}"

# Commit version 8.02
create_commit "${workdir_path}" -d "2013-07-01T08:48:45Z" -m "v8.02 downloaded from https://www.mediafire.com/?co54v1quk8vg9zb" "${SOURCES_DIRECTORY}/mcp802.zip"

# Reset the working tree and the index
clean_worktree_and_index "${workdir_path}"

# Commit commit 02330703452f19747a5fc68fc6cd89a52b6b6c1a
create_commit "${workdir_path}" -d "2013-07-01T22:34:00Z" -m "Mercurial commit 02330703452f19747a5fc68fc6cd89a52b6b6c1a downloaded from https://web.archive.org/web/20200624075051/https://bitbucket.org/Brunner/mcp/get/mcp%208.02.tar.bz2" -a "--strip-components=1 Brunner-mcp-02330703452f" "${SOURCES_DIRECTORY}/Brunner-mcp-02330703452f.tar.bz2"

# Reset the working tree and the index
clean_worktree_and_index "${workdir_path}"

# Commit commit 764b4373a179a24d628c1160a449a4886770c085
create_commit "${workdir_path}" -d "2013-07-03T23:19:00Z" -m "Mercurial commit 764b4373a179a24d628c1160a449a4886770c085 downloaded from https://web.archive.org/web/20200624075054/https://bitbucket.org/Brunner/mcp/get/mcp%208.03.tar.bz2" -a "--strip-components=1 Brunner-mcp-764b4373a179" "${SOURCES_DIRECTORY}/Brunner-mcp-764b4373a179.tar.bz2"

# Reset the working tree and the index
clean_worktree_and_index "${workdir_path}"

# Commit version 8.03
create_commit "${workdir_path}" -d "2013-07-06T13:26:44Z" -m "v8.03 downloaded from https://www.mediafire.com/?fu9b8voz4xeu29n" "${SOURCES_DIRECTORY}/mcp803.zip"

# Reset the working tree and the index
clean_worktree_and_index "${workdir_path}"

# Commit version 8.04
create_commit "${workdir_path}" -d "2013-07-07T11:40:55Z" -m "v8.04 downloaded from https://www.mediafire.com/?zddk7n54o8jgihz" "${SOURCES_DIRECTORY}/mcp804.zip"

# Reset the working tree and the index
clean_worktree_and_index "${workdir_path}"

# Commit commit 1614dadce76a624e2741ac2ee3eac002e5fd66b7
create_commit "${workdir_path}" -d "2013-07-08T07:32:00Z" -m "Mercurial commit 1614dadce76a624e2741ac2ee3eac002e5fd66b7 downloaded from https://web.archive.org/web/20200624075057/https://bitbucket.org/Brunner/mcp/get/mcp%208.04.tar.bz2" -a "--strip-components=1 Brunner-mcp-1614dadce76a" "${SOURCES_DIRECTORY}/Brunner-mcp-1614dadce76a.tar.bz2"

# Reset the working tree and the index
clean_worktree_and_index "${workdir_path}"

# Commit commit f44f0dae68ccf2bfa5681b4b51eabb8b4cbb155c
mkdir -p zip-workdir
ln -s ../workdir zip-workdir/Brunner-mcp-f44f0dae68cc
(cd zip-workdir ; unzip -q "${SOURCES_DIRECTORY}/Brunner-mcp-f44f0dae68cc.zip")
rm -rf zip-workdir
git -C "${workdir_path}" add :/
GIT_AUTHOR_DATE="2013-07-11T23:19:00Z" \
GIT_COMMITTER_DATE="2013-07-11T23:19:00Z" \
git -C "${workdir_path}" commit -m "Mercurial commit f44f0dae68ccf2bfa5681b4b51eabb8b4cbb155c downloaded from https://web.archive.org/web/20200624075018/https://bitbucket.org/Brunner/mcp/get/f44f0dae68cc.zip"

# Reset the working tree and the index
clean_worktree_and_index "${workdir_path}"

# Commit version 8.05
create_commit "${workdir_path}" -d "2013-07-16T08:22:24Z" -m "v8.05 downloaded from https://www.mediafire.com/?xcjy2o2zsdol7cu" "${SOURCES_DIRECTORY}/mcp805.zip"

# Reset the working tree and the index
clean_worktree_and_index "${workdir_path}"

# Commit version 8.11
create_commit "${workdir_path}" -d "2013-09-20T15:09:05Z" -m "v8.11 downloaded from https://www.mediafire.com/?96mrmeo57cdf6zv" "${SOURCES_DIRECTORY}/mcp811.zip"

# Reset the working tree and the index
clean_worktree_and_index "${workdir_path}"

# Commit version 9.03
create_commit "${workdir_path}" -d "2014-01-14T14:08:33Z" -m "v9.03 downloaded from https://www.mediafire.com/?q97ptg3ng85tpra" "${SOURCES_DIRECTORY}/mcp903.zip"

# Reset the working tree and the index
clean_worktree_and_index "${workdir_path}"

# Commit version 9.08
create_commit "${workdir_path}" -d "2014-06-26T23:31:00Z" -m "v9.08 downloaded from https://web.archive.org/web/20161107201113/http://www.modcoderpack.com/website/sites/default/files/releases/mcp908.zip" "${SOURCES_DIRECTORY}/mcp908.zip"

# Reset the working tree and the index
clean_worktree_and_index "${workdir_path}"

# Commit version 9.10
create_commit "${workdir_path}" -d "2014-09-30T15:17:00Z" -m "v9.10 downloaded from https://web.archive.org/web/20170721061036*/http://www.modcoderpack.com/website/sites/default/files/releases/mcp910.zip" "${SOURCES_DIRECTORY}/mcp910.zip"

# Reset the working tree and the index
clean_worktree_and_index "${workdir_path}"

# Commit version 9.18
create_commit "${workdir_path}" -d "2015-12-17T20:22:00Z" -m "v9.18 downloaded from https://web.archive.org/web/20170301124540*/http://www.modcoderpack.com/website/sites/default/files/releases/mcp918.zip" "${SOURCES_DIRECTORY}/mcp918.zip"

# Reset the working tree and the index
clean_worktree_and_index "${workdir_path}"

# Commit version 9.24
create_commit "${workdir_path}" -d "2016-06-08T07:47:00Z" -m "v9.24 downloaded from https://web.archive.org/web/20170301124922/http://www.modcoderpack.com/website/sites/default/files/releases/mcp924_1.zip" "${SOURCES_DIRECTORY}/mcp924_1.zip"

# Reset the working tree and the index
clean_worktree_and_index "${workdir_path}"

# Commit version 9.28
create_commit "${workdir_path}" -d "2016-06-08T07:59:00Z" -m "v9.28 downloaded from https://web.archive.org/web/20170301125146/http://www.modcoderpack.com/website/sites/default/files/releases/mcp928_1.zip" "${SOURCES_DIRECTORY}/mcp928_1.zip"

# Reset the working tree and the index
clean_worktree_and_index "${workdir_path}"

# Commit version 9.31
create_commit "${workdir_path}" -d "2016-06-23T14:12:00Z" -m "v9.31 downloaded from https://web.archive.org/web/20170301125358*/http://www.modcoderpack.com/website/sites/default/files/releases/mcp931.zip" "${SOURCES_DIRECTORY}/mcp931.zip"

# Reset the working tree and the index
clean_worktree_and_index "${workdir_path}"

# Commit version 9.37
create_commit "${workdir_path}" -d "2017-02-14T19:53:00Z" -m "v9.37 downloaded from https://web.archive.org/web/20170301125442/http://www.modcoderpack.com/website/sites/default/files/releases/mcp937.zip" "${SOURCES_DIRECTORY}/mcp937.zip"

# Reset the working tree and the index
clean_worktree_and_index "${workdir_path}"

# Commit version 9.40
create_commit "${workdir_path}" -d "2017-06-13T11:49:00Z" -m "v9.40 downloaded from http://www.modcoderpack.com/files/mcp940.zip" "${SOURCES_DIRECTORY}/mcp940.zip"
