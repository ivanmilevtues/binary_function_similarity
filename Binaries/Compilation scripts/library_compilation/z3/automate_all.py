import subprocess


def main():
    opts = ['0', '1', '2', '3', 's']
    clang_v = ['3.5', '5.0', '7', '9']
    gcc_v = ['4.8', '5.0', '7', '9']

    files = ['clang_arm32.sh', 'clang_arm64.sh', 'clang_x64.sh', 
             'clang_x86.sh', 'gcc_arm32.sh', 'gcc_x64.sh', 
             'gcc_x86.sh']

    for file in files:
        for comp_v in gcc_v:
            for opt in opts:
                subprocess.run(f'/usr/bin/timeout 15m bash ./{file} {comp_v} {opt}', shell=True)



if __name__ == '__main__':
    main()
