use std::fs::File;
use std::io::{stdout, Read, Write};

struct Config {
    use_little_endian: bool,
    group_size: usize
}

impl Config {
    pub fn from_args(args: &[String]) -> Self {
        let mut use_little_endian = false;
        let mut group_size = 2;
        let mut iter = args.iter().peekable();
        while let Some(arg) = iter.next() {
            match arg.as_str() {
                "-e" => use_little_endian = true,
                "-g" => {
                    match iter.peek() {
                        Some(value) => group_size = value.parse::<usize>().unwrap_or(2),
                        None => panic!("Invalid arguments"),
                    }
                }
                _ => {}
            }
        }
        if use_little_endian {
            group_size = group_size.max(4);
        }
        return Config { use_little_endian, group_size };
    }
}

fn print_lines(line: usize, buffer: [u8; 16], config: &Config) {
    let mut stdout = stdout();
    let offset = line * 16;
    _ = write!(stdout, "{:08x}: ", offset);

    for chunk in buffer.chunks(config.group_size) {
        if config.use_little_endian {
            chunk.iter().rev().for_each(|byte| _ = write!(stdout, "{:02x}", byte));
        } else {
            chunk.iter().for_each(|byte| _ = write!(stdout, "{:02x}", byte));
        }
        _ = write!(stdout, " ");
    }

    if config.use_little_endian {
        _ = write!(stdout, "  ");
    } else {
        _ = write!(stdout, " ");
    }

    for b in buffer.iter() {
        if *b >= 32 && *b <= 126 {
            _ = write!(stdout, "{}", *b as char);
        } else {
            _ = write!(stdout, ".");
        }
    }

    _ = write!(stdout, "\n");
    _ = stdout.flush();
}

fn main() {
    let args = std::env::args().skip(1).collect::<Vec<String>>();
    let Some(file_name) = args.iter().find(|arg| arg.contains(".")) else {
        panic!("Missing file name");
    };

    let config = Config::from_args(&args);

    let mut file = File::open(&file_name).expect("Unable to open file");
    let mut buffer = [0; 16];

    let mut line = 0;
    while let Ok(n) = file.read(&mut buffer) {
        if n == 0 {
            break;
        }
        print_lines(line, buffer, &config);
        line += 1;
    }
}
