use std::fs::File;
use std::io::{BufRead, BufReader};

fn main() -> std::io::Result<()> {
    let input = BufReader::new(File::open("input.txt")?).lines().next().unwrap().unwrap();

    let mut total_invalid: usize = 0;

    /*
    for id_pair in input.trim().split(",") {
        let mut id_minmax = id_pair.split("-");
        let min: usize = id_minmax.next().unwrap().parse().unwrap();
        let max: usize = id_minmax.next().unwrap().parse().unwrap();

        for number in min..=max {
            let num_string = number.to_string();
            let char_count = num_string.chars().count();

            if char_count % 2 == 0 {
                let (half1, half2) = num_string.split_at(char_count / 2);
                if half1 == half2 {
                    total_invalid += number;
                }
            }
        }
    }
    */

    input.trim().split(",").for_each(|id_pair| {
        let (min, max) = id_pair.split_once("-").map(|(a, b)| (a.parse::<usize>().unwrap(), b.parse::<usize>().unwrap())).unwrap();
        (min..=max).map(|x| x.to_string())
            .filter(|s| s.chars().count() % 2 == 0)
            .filter(|s| {let count = s.chars().count(); &s[..count/2] == &s[count/2..]})
            .for_each(|s| total_invalid += s.parse::<usize>().unwrap());
    });



    println!("part1: {}", total_invalid);

    Ok(())
}